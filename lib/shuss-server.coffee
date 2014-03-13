express = require 'express'
logger = require './shuss-logger'
livereload = require 'livereload'
path = require 'path'
# livereload = require 'livereload'

class ShussServer

  constructor: (@config)->
    @app = express()
    @_init()

  start:()->
    port = @config.get 'port'

    logger.debug 'starting server on port', port
    @server = @app.listen port

    if @config.get 'livereload'
      lrport = @config.get 'livereloadport'
      logger.debug 'starting livereload server on port', lrport
      # @lrserver = livereload.createServer()
      # @lrserver.watch @config.get 'dir'

  stop:()->
    return unless @server
    @server.close()

  _init:()->
    dir = @config.get 'dir'
    @app.use express.static dir
    @app.use express.directory dir

module.exports = ShussServer
