(function() {
  var ShussPluginLoader;

  ShussPluginLoader = (function() {
    function ShussPluginLoader(config, logger) {
      var pluginName, pluginNames, _i, _len, _ref;
      this.config = config;
      this.logger = logger;
      pluginNames = this.config.get("plugins");
      this.plugins = [];
      if (!pluginNames) {
        return;
      }
      this.logger.debug("Loading plugins [" + pluginNames + "]");
      _ref = pluginNames.split(',');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        pluginName = _ref[_i];
        this.loadPlugin(pluginName);
      }
    }

    ShussPluginLoader.prototype.loadPlugin = function(pluginName) {
      var error;
      this.logger.debug("Loading plugin " + pluginName);
      try {
        this.plugins.push(require("shuss-" + pluginName));
        return this.logger.debug("Loaded plugin " + pluginName);
      } catch (_error) {
        error = _error;
        throw "Unable to find plugin " + pluginName + ". Install it globally with:\n npm install -g shuss-" + pluginName;
      }
    };

    ShussPluginLoader.prototype.inject = function(app, express) {
      var plugin, _i, _len, _ref, _results;
      this.logger.debug("Injecting plugins");
      _ref = this.plugins;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        plugin = _ref[_i];
        _results.push(plugin.load(app, express, this.config));
      }
      return _results;
    };

    module.exports = ShussPluginLoader;

    return ShussPluginLoader;

  })();

}).call(this);
