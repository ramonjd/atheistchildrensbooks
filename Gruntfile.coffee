# dev local variables
devLocals = require './config/dev.locals.json'
distLocals = require './config/dist.locals.json'

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
                '!\\.html|\\.js|\\.svg|\\.css|\\.png|\\.gif|\\.jpg$ /index.html [L]'
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
      dist:
        options:
          data: (dest, src)->
            distLocals
        files:
          'dist/index.html' : 'src/jade/index.jade'
    less:
      dev:
        files:
          '.tmp/css/styles.css' : 'src/less/styles.less'
      dist:
        options:
          compress: true
        files:
          'dist/css/styles.min.css' : 'src/less/styles.less'
    uglify:
      options:
        mangle: false
      dist:
        files:
          'dist/js/acb.min.js': devLocals.vendor.concat devLocals.scripts.body
          'dist/js/scripts.js' : devLocals.scripts.head
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
  # custom tasks
  #
  grunt.registerTask 'createImgJs', 'recurse through img dir', ()->
    imgs = []
    dest = '.tmp/js/preloaderAssets.js'
    contents = 'acb.preloaderAssets=['
    grunt.file.recurse 'src/img/', (abspath, rootdir, subdir, filename)->
      imgs.push '\'/img/' + filename + '\''
    contents += imgs + '];'
    grunt.file.write dest, contents
    console.log(dest + ' created')
  
  #
  # load modules
  #
  require('load-grunt-tasks')(grunt)
  
  #
  # register tasks
  #
  grunt.registerTask 'compile', [
    'clean:dev'
    #'createImgJs'
    'less:dev'
    'coffee:dev'
    'copy:dist'
    'jade:compile'
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
    'clean:dist'
    'less:dist'
    'coffee:dev'
    'copy:dist'
    'jade:dist'
    'uglify'
  ]
  grunt.registerTask 'default', [
    'compile'
    'server'
  ]
  # return grunt
  grunt