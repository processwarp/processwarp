/** processwarp namespace and members. */

/** global namespace(no member). */
var global = {};
var processwarp = (function(document, window, global) {
  const PROCESSWARP = require('./dist/gui');
  return new PROCESSWARP(document, window, global);
})(document, window, global);

