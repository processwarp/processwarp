'use strict';

// Load modules.
import electron from 'electron';

// Load local modules.
import {NID, MODULE} from './constant';
import PacketController from './packet_controller';

// Get inner modules.
const ipc = electron.ipcRenderer;
const remote = electron.remote;

const HEARTBEAT_TERM = 3;

const STATUS = {
  NORMAL: 0,
  WAIT_WARP: 1
};

export default class GUI {
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
    setTimeout(this.onBeat, 1);
  }

  /**
   * Bind IPC names and methods.
   */
  initializeIpc() {
    ipc.on('gui_property', this.recvProperty);
    ipc.on('gui_relay_packet', this.recvPacke);
  }

  /**
   * Get canvas, context and store instance to global object.
   * @return {void}
   */
  initializeCanvas() {
    this.global.canvasFore = this.document.getElementById('canvas_fore');
    this.global.contextFore = this.global.canvas_fore.getContext('2d');

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
    this.global.canvas_fore.width = this.document.body.clientWidth;
    this.global.canvas_fore.height = this.document.body.clientHeight;

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
    setTimeout(this.onBeat, HEARTBEAT_TERM * 1000);
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
    this.property = prop;
    this.packetController.initialize(this.property.nid, this.onRecv, this.onSend);
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
