#!/usr/bin/env coffee

program = require('commander')
ShussServer = require './shuss-server'

class ShussCli
  constructor:(@program)->
    @program
      .version('0.0.0')
      .option('-d, --dir <value>', 'served files directory')
      .option('-v, --verbose', 'speak to me')
      .option('-f, --file <path>', 'additional config file')
      .option('-l, --livereload [port]', 'enable livereload, optionnaly give a port', parseInt)

    startCommand = program.command 'start [port]'
    startCommand.action @_startAction

  run:(@config, @logger)=>
    @program.parse process.argv

    @_startAction() if @program.args.length == 0


  _loadCliArgs: ()->
    cliArgs = {}
    @program.verbose && cliArgs.verbose = @program.verbose
    @program.dir && cliArgs.dir = @program.dir
    # @program.livereload && cliArgs.livereload = @program.livereload

    lr = @program.livereload
    unless typeof lr is 'undefined' # don't tuch anything unless -l given
      if lr
        cliArgs.livereload = true # enable lr
        if typeof lr is 'number' # set the port if given one
          cliArgs.livereloadport = lr
      else
        cliArgs.livereload = false

    @config.load cliArgs
    @config.loadFile path if path = @program.file
    @config.validate()
    @logger.resetConfig()

  _startAction: (port)=>
    @logger.debug 'starting'
    @_loadCliArgs()
    port && @config.set 'port', port

    @logger.debug 'config', @config.toString()

    server = new ShussServer(@config, @logger)
    server.start()

module.exports = new ShussCli program
