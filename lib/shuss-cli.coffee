program = require('commander')
ShussServer = require './shuss-server'

class ShussCli

  @ascii = "                   ❄                      ❄\n" +
      "❄  _____ __    ❄              ❄     (ツ)\n" +
      "  / ___// /_  __  ____________    o––\\ \\--o   ❄\n" +
      '  \\__ \\/ __ \\/ / / / ___/ ___/   /   /–/   \\\n' +
      " ___/ / / / / /_/ (__  |__  )   /    \\ \\/   \\\n" +
      "/____/_/ /_/\\__,_/____/____/         / /  ❄ \n" +
      "                              ❄     / /\n" +
      " ❄                   ❄                       ❄\n"
      # "   _____ __                       \n" +
      # "  / ___// /_  __  ____________    \n" +
      # "  \\__ \\/ __ \\/ / / / ___/ ___/ \n" +
      # " ___/ / / / / /_/ (__  |__  )    \n" +
      # "/____/_/ /_/\\__,_/____/____/ ❄   \n"

  constructor:(@program)->
    @program
      .version('0.1.1')
      .option('-d, --dir <value>', 'served files directory')
      .option('-v, --verbose', 'speak to me')
      .option('-f, --file <path>', 'additional config file')
      .option('-l, --livereload [port]', 'enable livereload, optionnaly give a port', parseInt)

    startCommand = program.command 'start [port]'
    startCommand.action @_startAction

  run:(@config, @logger)=>
    @program.parse process.argv

    @_startAction() if @program.args.length == 0
    @_startAction(@program.args[0]) if @program.args.length == 1


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
    @_showAscii()
    @logger.debug 'starting'
    @_loadCliArgs()
    port && @config.set 'port', port

    @logger.debug 'config', @config.toString()

    server = new ShussServer(@config, @logger)
    server.start()

  _showAscii: ()->
    console.log ShussCli.ascii

module.exports = new ShussCli program
