(function() {
  var ShussCli, ShussPluginLoader, ShussServer, yargs,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  yargs = require('yargs').usage('shuss [options...]').options('d', {
    alias: 'dir',
    "default": '.',
    describe: 'Served files directory'
  }).options('p', {
    alias: 'port',
    "default": '1234',
    describe: 'Runs Shuss on the specified port'
  }).options('verbose', {
    boolean: true,
    describe: 'Speak to me'
  }).options('l', {
    alias: 'livereload',
    boolean: false,
    describe: 'Enables LiveReload'
  }).options('livereload_port', {
    "default": '35729',
    describe: 'Runs LiveReload on the specified port'
  }).options('f', {
    alias: 'file',
    describe: 'Config file path'
  }).options('v', {
    alias: 'version',
    boolean: true,
    describe: 'Return actual Shuss version'
  }).options('h', {
    alias: 'help',
    boolean: true,
    describe: 'Displays Shuss help'
  }).options('P', {
    alias: 'plugins',
    describe: 'list of plugins to be loaded'
  });

  ShussServer = require('./shuss-server');

  ShussPluginLoader = require('./shuss-plugin-loader');

  ShussCli = (function() {
    function ShussCli(yargs) {
      this.yargs = yargs;
      this.run = __bind(this.run, this);
      this.argv = this.yargs.argv;
    }

    ShussCli.prototype.run = function(config, logger) {
      this.config = config;
      this.logger = logger;
      if (this.argv.version) {
        return this._version();
      } else if (this.argv.help) {
        return this._help();
      } else {
        return this._start();
      }
    };

    ShussCli.prototype._version = function() {
      return console.log(require('../package').version);
    };

    ShussCli.prototype._help = function() {
      return console.log(this.yargs.help());
    };

    ShussCli.prototype._start = function() {
      var path, pluginLoader;
      this.logger.debug('starting');
      this.config.load(this.argv);
      if (path = this.argv.file) {
        this.config.loadFile(path);
      }
      this.config.validate();
      this.logger.resetConfig();
      pluginLoader = new ShussPluginLoader(this.config, this.logger);
      return new ShussServer(this.config, this.logger, pluginLoader).start();
    };

    return ShussCli;

  })();

  module.exports = new ShussCli(yargs);

}).call(this);
