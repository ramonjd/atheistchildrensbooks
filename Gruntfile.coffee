module.exports = (grunt)->

  # API for the mock json
  routes = require('./api/routes')(grunt)
  cors = require './api/cors'

  # dev local variables
  devLocals = require './config/dev.locals.json'
  distLocals = require './config/dist.locals.json'
  apiPaths= require './config/api.paths.json'

  # rewrite middleware
  modRewrite = require 'connect-modrewrite'
  mountFolder = (connect, dir) ->
    connect.static(require('path').resolve(dir))

  # custom functions
  createImgJSON = ()->
    imgs = []
    grunt.file.recurse 'src/img/', (abspath, rootdir, subdir, filename)->
      imgs.push '/img/' + filename
    imgs

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
    # https://blog.gaya.ninja/articles/static-mockup-data-endpoints-connect/
      api:
        options:
          port: 8080
          hostname: 'localhost'
          middleware: (connect, options, middlewares)->
            middlewares.push cors
            middlewares.push routes
            middlewares
      dev:
        options:
          port: grunt.option('port') || 8000
          middleware: (connect)->
            middlewares = [
              modRewrite([
                '!\\.html|\\.js|\\.svg|\\.css|\\.png|\\.gif|\\.jpg|\\.eot|\\.ttf|\\.woff$ /index.html [L]'

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
          {
            expand:true
            filter:'isFile'
            flatten:true
            src: [
              'src/.htaccess'
            ]
            dest: 'dist/'
          }
          {
            expand:true
            cwd: 'bower_components/bootstrap/'
            src: [
              'fonts/*'
            ]
            dest: 'dist/'
          }
        ]
      dev:
        files: [
          {
            expand:true
            cwd: 'bower_components/bootstrap/'
            src: [
              'fonts/*'
            ]
            dest: '.tmp/'
          }
        ]
    html2js:
      options:
        quoteChar: '\''
        useStrict: true
        base: '.tmp/'
        module: 'acb.templates'
        htmlmin:
          removeComments: true
          collapseWhitespace: true
      dev:
        src: ['.tmp/templates/*.tpl.html']
        dest: '.tmp/js/templates.js'
    jade:
      compile:
        options:
          pretty: true
          data: (dest, src)->
            devLocals
        files:
          '.tmp/index.html' : 'src/jade/index.jade'
      views:
        options:
          client: false
          pretty: true
        files: [
          {
            cwd: 'src/jade/views'
            src: '**/*.jade'
            dest: '.tmp/templates'
            expand: true
            ext: '.tpl.html'
          }
        ]
      partials:
        options:
          client: false
          pretty: true
        files: [
          {
            cwd: 'src/jade/partials'
            src: '**/*.jade'
            dest: '.tmp/templates'
            expand: true
            ext: '.tpl.html'
          }
        ]
      dist:
        options:
          data: (dest, src)->
            distLocals
        files:
          'dist/index.html' : 'src/jade/index.jade'
    less:
      dev:
        files:
          '.tmp/css/base.css' : 'src/less/styles.less'
      dist:
        options:
          compress: true
        files:
          'dist/css/base.min.css' : 'src/less/styles.less'
    ngconstant:
      options:
        name: 'acb.constants'
        dest: '.tmp/js/constants.js'
      dev:
        constants:
          ENV:
            BASE: 'http://localhost:8080'
            URLS: apiPaths
          IMGS: createImgJSON()
      dist:
        constants:
          ENV:
            BASE: 'http://atheistchildrensbooks.org'
            URLS: apiPaths
          IMGS: createImgJSON()
    uglify:
      options:
        mangle: false
      dist:
        files:
          'dist/js/app.min.js': devLocals.vendor.concat devLocals.scripts.body
          'dist/js/scripts.js' : devLocals.scripts.head
    watch:
      html:
        files: 'src/jade/**/*.jade'
        tasks: ['jade', 'jade:views', 'jade:partials', 'html2js:dev']
      locals:
        files: 'config/*.locals.json'
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
    'ngconstant:dev'
    'jade'
    'jade:views'
    'jade:partials'
    'html2js:dev'
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
    'compile'
    'ngconstant:dist'
    'clean:dist'
    'uglify:dist'
    'less:dist'
    'copy:dist'
    'jade:dist'
  ]
  grunt.registerTask 'default', [
    'compile'
    'server'
  ]
  # return grunt
  grunt