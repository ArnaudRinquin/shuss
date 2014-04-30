module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.initConfig
    coffee:
      compile:
        expand: true
        flatten: true
        cwd: 'src/'
        src: ['*.coffee']
        dest: 'lib/'
        ext: '.js'

  grunt.registerTask 'default', ['coffee:compile']
