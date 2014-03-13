config = require './shuss-config'
winston = require 'winston'

winston.resetConfig = ()->
  if config.get 'verbose'
    winston.remove(winston.transports.Console)
    winston.add(winston.transports.Console, {
      level: 'debug'
      colorize: true
    })

winston.resetConfig()

module.exports = winston
