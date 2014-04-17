argv = require('yargs')
      .options('d', {
        alias: 'dir',
        default: '.',
        describe: 'Served files directory'
      })
      .options('p', {
        alias: 'port',
        default: '1234',
        describe: 'Runs Shuss on the specified port'
      })
      .options('verbose', {
        boolean: true,
        describe: 'Speak to me'
      })
      .options('l', {
        alias: 'livereload'
        boolean: true,
        describe: 'Enables LiveReload'
      })
      .options('f', {
        alias: 'file',
        describe: 'Config file path'
      })
      .options('v', {
        alias: 'version'
        boolean: true,
        describe: 'Return actual Shuss version'
      })
      .argv
ShussServer = require './shuss-server'

class ShussCli
  constructor:(@argv)->

  run:(@config, @logger)=>
    if @argv.version
      @_version()
    else
      @_start()

  _version: ()->
    console.log require('../package').version

  _start: ()->
    @logger.debug 'starting'

    @config.load @argv
    @config.loadFile path if path = @argv.file
    @config.validate()
    @logger.resetConfig()

    new ShussServer(@config, @logger).start()

module.exports = new ShussCli argv
