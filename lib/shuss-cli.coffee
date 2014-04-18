yargs = require('yargs')
      .usage('shuss [options...]')
      .options 'd',
        alias: 'dir'
        default: '.'
        describe: 'Served files directory'
      .options 'p',
        alias: 'port'
        default: '1234'
        describe: 'Runs Shuss on the specified port'
      .options 'verbose',
        boolean: true
        describe: 'Speak to me'
      .options 'l',
        alias: 'livereload'
        boolean: false
        describe: 'Enables LiveReload'
      .options 'livereload_port',
        default: '35729'
        describe: 'Runs LiveReload on the specified port'
      .options 'f',
        alias: 'file'
        describe: 'Config file path'
      .options 'v',
        alias: 'version'
        boolean: true
        describe: 'Return actual Shuss version'
      .options 'h',
        alias: 'help'
        boolean: true
        describe: 'Displays Shuss help'
      .options 'P',
        alias: 'plugins'
        describe: 'list of plugins to be loaded'
ShussServer = require './shuss-server'

class ShussCli
  constructor:(@yargs)->
    @argv = @yargs.argv

  run:(@config, @logger)=>
    if @argv.version
      @_version()
    else if @argv.help
      @_help()
    else
      @_start()

  _version: ()->
    console.log require('../package').version

  _help: ()->
    console.log @yargs.help()

  _start: ()->
    @logger.debug 'starting'

    @config.load @argv
    @config.loadFile path if path = @argv.file
    @config.validate()
    @logger.resetConfig()

    new ShussServer(@config, @logger).start()

module.exports = new ShussCli yargs
