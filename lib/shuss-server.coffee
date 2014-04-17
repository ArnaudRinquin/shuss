express = require 'express'
livereload = require 'livereload'
path = require 'path'

class ShussServer

  constructor: (@config, @logger)->
    @app = express()
    @_init()

  start:()->
    port = @config.get 'port'

    @logger.debug 'starting server on port', port
    @server = @app.listen port

    if @config.get 'livereload'
      lrport = @config.get 'livereloadport'
      @logger.debug 'starting livereload server on port', lrport
      dir = @_getResolvedDir()
      @lrserver = livereload.createServer {
        port: lrport
      }
      @lrserver.watch dir

  stop:()->
    return unless @server
    @server.close()

  _init:()->
    dir = @_getResolvedDir()
    @logger.info 'serving', dir, "on http://0.0.0.0:#{@config.get 'port'}"
    @app.use express.static dir
    @app.use express.directory dir

  _getResolvedDir:()->
    path.resolve @config.get 'dir'

module.exports = ShussServer
