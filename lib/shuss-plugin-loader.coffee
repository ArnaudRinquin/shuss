class ShussPluginLoader
  constructor: (@config, @logger)->
    pluginNames = @config.get "plugins"
    @plugins = []

    return unless pluginNames

    @logger.debug "Loading plugins [#{pluginNames}]"

    @loadPlugin(pluginName) for pluginName in pluginNames.split(',')

  loadPlugin: (pluginName)->
    @logger.debug "Loading plugin #{pluginName}"
    try
      @plugins.push require "shuss-#{pluginName}"
      @logger.debug "Loaded plugin #{pluginName}"
    catch error
      throw "Unable to find plugin #{pluginName}. Install it globally with:\n
      npm install -g shuss-#{pluginName}"

  inject: (app, express)->
    @logger.debug "Injecting plugins"
    for plugin in @plugins
      plugin.load(app, express, @config)

  module.exports = ShussPluginLoader
