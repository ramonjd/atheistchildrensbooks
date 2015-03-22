# dev local variables
devLocals = require './config/dev.locals.json'

# rewrite middleware
modRewrite = require 'connect-modrewrite'
mountFolder = (connect, dir) ->
  connect.static require('path').resolve(dir)

module.exports = (grunt)->
  grunt.initConfig(
    pkg: grunt.file.readJSON('package.json')
    #
    # task definitions
    #
    clean:
      dev: [
        '.tmp'
      ]
      dist: [
        'dist'
      ]
    coffee:
      dev:
        options:
          bare: true
        expand: true,
        flatten: true
        cwd: 'src/coffee'
        src: ['**/*.coffee']
        dest: '.tmp/js'
        ext: '.js'
    connect:
      dev:
        options:
          port: grunt.option('port') || 8000
          middleware: (connect)->
            middlewares = [
              modRewrite([
                '!\\.html|\\.js|\\.svg|\\.css|\\.png|\\.jpg$ /index.html [L]'
              ])
              mountFolder connect, './'
              mountFolder connect, '.tmp/'
              mountFolder connect, 'src/'
            ]
      dist:
        options:
          port: 8001
          middleware: (connect)->
            [mountFolder connect, 'dist/']
    copy:
      dist:
        files: [
          {
            expand:true
            cwd: 'src/img/'
            src: [
              '**'
            ]
            dest: 'dist/img/'
          }
        ]
      dev:
        files: [
        ]
    jade:
      compile:
        options:
          pretty: true
          data: (dest, src)->
            devLocals
        files:
          '.tmp/index.html' : 'src/jade/index.jade'
      ###    
      dist:
        options:
          data: (dest, src)->
            distLocals
        files:
          'dist/index.html' : 'src/jade/index.jade'
      ###
    less:
      dev:
        files:
          '.tmp/css/base.css' : 'src/less/base.less'
      dist:
        options:
          compress: true
        files:
          'dist/css/base.min.css' : 'src/less/base.less'
    watch:
      html:
        files: 'src/jade/**/*.jade'
        tasks: ['jade']
      coffee:
        files: 'src/coffee/**/*.coffee'
        tasks: ['coffee:dev']
      less:
        files: 'src/less/*.less'
        tasks: ['less:dev']
    )
  
  #
  # load modules
  #
  require('load-grunt-tasks')(grunt)
  
  #
  # register tasks
  #
  grunt.registerTask 'compile', [
    'clean:dev'
    'less:dev'
    'coffee:dev'
    'copy:dev'
    'jade'
  ]
  grunt.registerTask 'server', [
    'connect'
    'watch'
  ]
  grunt.registerTask 'test', [
  ]
  grunt.registerTask 'dev', [
  ]
  grunt.registerTask 'dist', [
  ]
  grunt.registerTask 'default', [
    'compile'
    'server'
  ]
  # return grunt
  grunt