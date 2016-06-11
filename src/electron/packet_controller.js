import {NID, PACKET_MODE} from './constant';

export default class PacketController {
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
