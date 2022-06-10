var exec = require('cordova/exec');

var PLUGIN_NAME = 'Demo';

const methods = [
  'echo'
];

module.exports = methods.reduce((e, m) => {
  e[m] = args =>
    new Promise((resolve, reject) =>
      exec(resolve, reject, PLUGIN_NAME, m, args ? [args] : []),
    );
  return e;
}, {});
