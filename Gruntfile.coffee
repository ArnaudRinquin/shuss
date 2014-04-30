module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.initConfig
    coffee:
      compile:
        files:
          'lib/shuss-cli.js': 'src/shuss-cli.coffee'
          'lib/shuss-config.js': 'src/shuss-config.coffee'
          'lib/shuss-logger.js': 'src/shuss-logger.coffee'
          'lib/shuss-plugin-loader.js': 'src/shuss-plugin-loader.coffee'
          'lib/shuss-server.js': 'src/shuss-server.coffee'

  grunt.registerTask 'default', ['coffee:compile']
