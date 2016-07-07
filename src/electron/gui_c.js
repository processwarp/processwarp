'use strict';

// Load modules.
const electron = require('electron');

// Get inner modules.
const ipc = electron.ipcRenderer;
const remote = electron.remote;

const HEARTBEAT_TERM = 3;

const MODULE = {
  MEMORY: 0x00000001,
  VM: 0x00000002,
  SCHEDULER: 0x00000004,
  NETWORK: 0x00000008,
  CONTROLLER: 0x00000010,
  GUI: 0x00000020
};

const NID = {
  NONE: '',
  THIS: '.',
  BROADCAST: '*',
  SERVER: 'server'
};

const PACKET_MODE = {
  EXPLICIT: 0x00000001,
  ONE_WAY: 0x00000002
};

const STATUS = {
  NORMAL: 0,
  WAIT_WARP: 1
};

class PacketController {
  /**
   * Constructor with a module that parent module of this instance.
   * @param {MODULE} srcModule Moule type.
   */
  constructor(srcModule) {
    // Member values.
    this.containers = {};
    this.myNid = NID.NONE;
    this.srcModule = srcModule;

    // Callbacks.
    this.onRecv = null;
    this.onSend = null;
  }

  execute() {
  }

  /**
   * Initialize module with node-id of this node and call back method.
   * @param {NID} myNid The node-id of this node.
   * @param {function} onRecv A callback function for processing on receiveing packet.
   * @param {function} onSend A callback function for sending packet.
   */
  initialize(myNid, onRecv, onSend) {
    this.myNid = myNid;
    this.onRecv = onRecv;
    this.onSend = onSend;
  }

  /**
   * Receive packet and call capable reply or error method.
   * If pacekt is another type, call delegate method for general process.
   * @param {object} packet A received packet.
   */
  recv(packet) {
    if (packet.command === 'reply') {
      if (packet.packetId in this.containers) {
        const container = this.containers[packet.packetId];
        if ('onReply' in container) {
          container.onReply(packet);
        }
        delete this.containers[packet.packetId];
      }
    } else if (packet.command === 'error') {
      if (packet.packetId in this.containers) {
        const container = this.containers[packet.packetId];
        if ('onError' in container) {
          container.onError(packet);
        }
        delete this.containers[packet.packetId];
      }
    } else if (packet.command === 'packet_error') {
      if (packet.packetId in this.containers) {
        const container = this.containers[packet.packetId];
        if ('onPacketError' in container) {
          container.onPacketError(packet);
        }
        delete this.containers[packet.packetId];
      }
    } else {
      this.onRecv(packet);
    }
  }

  /**
   * Send a packet that having reply and/or error process.
   * @param {object} p A parameter set.
   */
  send(p) {
    console.assert('command' in p);
    console.assert('dstModule' in p);
    console.assert('pid' in p);
    console.assert('dstNid' in p);
    console.assert('content' in p);

    let packetId = Math.floor(Math.random() * 0xFFFFFFFF).toString(16);
    while (packetId in this.containers) {
      packetId = Math.floor(Math.random() * 0xFFFFFFFF).toString(16);
    }

    let mode = 0;
    if ('isExplicit' in p && p.isExplicit) {
      mode |= PACKET_MODE.EXPLICIT;
    }

    if ('onReply' in p || 'onError' in p || 'onPacketError' in p) {
      const container = {
        onReply: p.onReply,
        onError: p.onError,
        onPacketError: p.onPacketError
      };
      this.containers[packetId] = container;
    } else {
      mode |= PACKET_MODE.ONE_WAY;
    }

    const packet = {
      packetId: packetId,
      command: p.command,
      mode: mode,
      dstModule: p.dstModule,
      srcModule: this.srcModule,
      pid: p.pid,
      dstNid: p.dstNid,
      srcNid: this.myNid,
      content: p.content
    };

    this.onSend(packet);
  }

  /**
   * Send a reply packet for the received packet.
   * @param {object} replyFor Received packet.
   * @param {object} content Packet content.
   */
  sendReply(replyFor, content) {
    const packet = {
      packetId: replyFor.packetId,
      command: 'reply',
      mode: PACKET_MODE.ONE_WAY,
      dstModule: replyFor.srcModule,
      srcModule: this.srcModule,
      pid: replyFor.pid,
      dstNid: replyFor.srcNid,
      srcNid: this.myNid,
      content: content
    };

    this.onSend(packet);
  }

  /**
   * Send a error packet for the received packet.
   * @param {object} errorFor Received packet.
   * @param {object} content Packet content.
   */
  sendError(errorFor, content) {
    const packet = {
      packetId: errorFor.packetId,
      command: 'error',
      mode: PACKET_MODE.ONE_WAY,
      dstModule: errorFor.srcModule,
      srcModule: this.srcModule,
      pid: errorFor.pid,
      dstNid: errorFor.srcNid,
      srcNid: this.myNid,
      content: content
    };

    this.onSend(packet);
  }
}

class GUI {
  constructor(document, window, global) {
    // Member values.
    this.document = document;
    this.global = global;
    this.property = null;
    this.status = STATUS.NORMAL;
    this.warpTargetNid = null;
    this.window = window;
    // Member modules.
    this.packetController = new PacketController(MODULE.GUI);
  }

  /**
   * When html has load, call all initialize methods, and send gui_load message.
   * @return {void}
   */
  initialize() {
    this.initializeIpc();
    this.initializeCanvas();
    this.initializeOnResize();

    // When loading html was finished, send gui_load command to main thread.
    ipc.send('gui_load');

    // Start beat.
    let THIS = this;
    setTimeout(function() {
      THIS.onBeat();
    }, 1);
  }

  /**
   * Bind IPC names and methods.
   */
  initializeIpc() {
    let THIS = this;
    ipc.on('gui_property', function(event, packet) {
      THIS.recvProperty(event, packet);
    });
    ipc.on('gui_relay_packet', function(event, packet) {
      THIS.recvPacket(event, packet);
    });
  }

  /**
   * Get canvas, context and store instance to global object.
   * @return {void}
   */
  initializeCanvas() {
    this.global.canvasFore = this.document.getElementById('canvas_fore');
    this.global.contextFore = this.global.canvasFore.getContext('2d');

    this.global.canvas = this.document.getElementById('canvas_back');
    this.global.context = this.global.canvas.getContext('2d');
  }

  /**
   * Add event when window size has changed, resize canvas size to fit.
   * @return {void}
   */
  initializeOnResize() {
    // Set first resize method.
    this.global.resizeTimer = setTimeout(this.onResize, 100);

    // When resize event was happen, update timeout.
    this.window.addEventListener('resize', function() {
      clearTimeout(global.resize_timer);

      global.resizeTimer = setTimeout(this.onResize, 100);
    });
  }

  /**
   * When resize window, resize canvas to the same size.
   */
  onResize() {
    this.global.canvasFore.width = this.document.body.clientWidth;
    this.global.canvasFore.height = this.document.body.clientHeight;

    this.global.canvas.width = this.document.body.clientWidth;
    this.global.canvas.height = this.document.body.clientHeight;
  }

  /**
   * When raise timer event for beat, send heartbeat_gui command when status is normal,
   * send warp_gui command when waiting warp.
   */
  onBeat() {
    switch (this.status) {
      case STATUS.NORMAL:
        this.sendCommandHeartbeatGui();
        break;

      case STATUS.WAIT_WARP:
        this.sendCommandWarpGui();
        break;

      default:
        // @todo error
        console.assert(false);
        break;
    }
    // Set next event.
    let THIS = this;
    setTimeout(function() {
      THIS.onBeat();
    }, HEARTBEAT_TERM * 1000);
  }

  /**
   * @param packet A recieved packet.
   */
  onRecv(packet) {
    switch (packet.command) {
      case 'heartbeat_gui':
        this.recvCommandHeartbeatGui(packet);
        break;

      case 'script':
        this.recvCommandScript(packet);
        break;

      case 'require_warp_gui':
        this.recvCommandRequireWarpGui(packet);
        break;

      default:
        // @todo error
        console.assert(false, 'command:' + packet.command);
        break;
    }
  }

  /**
   * Send packet throuhg the main thread.
   * @param packet {object} A packet to send.
   * @return {void}
   */
  onSend(packet) {
    ipc.send('gui_relay_packet', packet);
  }

  /**
   * When receive script, execute script.
   * @param event {object} Event instance from ipc.
   * @param script {string} Script string.
   */
  recvPacket(event, packet) {
    this.packetController.recv(packet);
  }

  /**
   * When receive heartbeat_gui command from another node, close GUI if on warp sequence.
   * @param packet {object} Command packet.
   * @return {void}
   */
  recvCommandHeartbeatGui(packet) {
    if (packet.src_nid === this.property.nid) {
      return;
    }
    console.assert(this.status !== STATUS.NORMAL);

    if (this.status === STATUS.WAIT_WARP) {
      remote.getCurrentWindow().close();
    }
  }

  /**
   * When receive require_warp_gui command, save target node-id and send warp_gui command.
   * Ignore if GUI status isn't NORMAL (ex. On warp sequence to another node).
   * Ignore if target node is this node.
   * @param packet {object} Command packet.
   * @return {void}
   */
  recvCommandRequireWarpGui(packet) {
    if (this.status !== STATUS.NORMAL || packet.content.target_nid === this.property.nid) {
      return;
    }

    this.warpTargetNid = packet.content.target_nid;
    this.status = STATUS.WAIT_WARP;
    this.sendCommandWarpGui();
  }

  /**
   * When receive script command, execute script as Javascript.
   * @param pid {sring} Process-id send to.
   * @param param {object} Parameter contain script string.
   * @return {void}
   */
  recvCommandScript(packet) {
    Function(packet.content.script)();
  }

  /**
   * When receive property from main process, save it and initialize PacketController.
   * @param event {object} Not used.
   * @param prop Property hash.
   * @return {void}
   */
  recvProperty(event, prop) {
    console.assert(this.property === null);
    let THIS = this;
    this.property = prop;
    this.packetController.initialize(
      this.property.nid,
      function(packet) {
        THIS.onRecv(packet);
      },
      function(packet) {
        THIS.onSend(packet);
      });
  }

  /**
   * Send warp_gui command to SCHEDULER module.
   * @return {void}
   */
  sendCommandWarpGui() {
    this.packetController.send({
      command: 'warp_gui',
      isExplicit: true,
      dstModule: MODULE.SCHEDULER,
      pid: this.property.pid,
      dstNid: this.warpTargetNid,
      content: {}
    });
  }

  /**
   * Send heartbeat_gui command to SCHEDULER and GUI module.
   * @return {void}
   */
  sendCommandHeartbeatGui() {
    if (this.property.pid === null) {
      return;
    }
    this.packetController.send({
      command: 'heartbeat_gui',
      isExplicit: true,
      dstModule: MODULE.SCHEDULER,
      pid: this.property.pid,
      dstNid: NID.BROADCAST,
      content: {}
    });
    this.packetController.send({
      command: 'heartbeat_gui',
      isExplicit: true,
      dstModule: MODULE.GUI,
      pid: this.property.pid,
      dstNid: NID.BROADCAST,
      content: {}
    });
  }
}
