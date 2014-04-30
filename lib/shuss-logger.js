(function() {
  var config, winston;

  config = require('./shuss-config');

  winston = require('winston');

  winston.resetConfig = function() {
    if (config.get('verbose')) {
      winston.remove(winston.transports.Console);
      return winston.add(winston.transports.Console, {
        level: 'debug',
        colorize: true
      });
    }
  };

  winston.resetConfig();

  module.exports = winston;

}).call(this);
