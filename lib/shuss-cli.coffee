#!/usr/bin/env coffee

program = require('commander')
ShussServer = require './shuss-server'
config = require './shuss-config'
logger = require './shuss-logger'

program
  .version('0.0.0')
  .option('-d, --dir [value]', 'served files directory')
  .option('-p, --port <n>', 'listened port', parseInt)
  .option('-v, --verbose', 'speak to me')
  .option('-l, --livereload', 'enable livereload')

loadCliArgs = ()->
  cliArgs = {}
  program.verbose && cliArgs.verbose = program.verbose
  program.dir && cliArgs.dir = program.dir
  program.livereload && cliArgs.livereload = program.livereload
  # program.port && cliArgs.port = program.port

  config.load cliArgs
  config.validate()
  logger.resetConfig()

startAction = (port)->
  loadCliArgs()
  port && config.set 'port', port

  logger.debug 'config', config.toString()

  server = new ShussServer(config)
  server.start()

startCommand = program.command 'start [port]'
startCommand.action startAction

program.parse process.argv
