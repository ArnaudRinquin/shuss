(function() {
  var ShussServer, express, livereload, path;

  express = require('express');

  livereload = require('livereload');

  path = require('path');

  ShussServer = (function() {
    function ShussServer(config, logger, pluginLoader) {
      this.config = config;
      this.logger = logger;
      this.pluginLoader = pluginLoader;
      this.app = express();
      this._init();
    }

    ShussServer.prototype.start = function() {
      var dir, lrport, port;
      port = this.config.get('port');
      this.logger.debug('starting server on port', port);
      this.server = this.app.listen(port);
      if (this.config.get('livereload')) {
        lrport = this.config.get('livereload_port');
        this.logger.debug('starting livereload server on port', lrport);
        dir = this._getResolvedDir();
        this.lrserver = livereload.createServer({
          port: lrport
        });
        return this.lrserver.watch(dir);
      }
    };

    ShussServer.prototype.stop = function() {
      if (!this.server) {
        return;
      }
      return this.server.close();
    };

    ShussServer.prototype._init = function() {
      var dir;
      dir = this._getResolvedDir();
      this.pluginLoader.inject(this.app, express);
      this.logger.info('serving', dir, "on http://0.0.0.0:" + (this.config.get('port')));
      this.app.use(express["static"](dir));
      return this.app.use(express.directory(dir));
    };

    ShussServer.prototype._getResolvedDir = function() {
      return path.resolve(this.config.get('dir'));
    };

    return ShussServer;

  })();

  module.exports = ShussServer;

}).call(this);
