module.exports = function(grunt) {
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        dart2js: {
            dist: {
                options: {
                    checked: true,
                    dart2js_bin: '/usr/lib/dart/bin/dart2js'
                },
                files: {
                    'public/js/app.js': 'dart/bin/main.dart'
                }
            }
        },
        watch: {
            options: {
              minify: true
            },
            dart: {
                files: ['**/*.dart'],
                tasks: ['dart2js']
            }
        }
    });

    grunt.loadNpmTasks('grunt-dart2js');
    grunt.loadNpmTasks('grunt-contrib-watch');

    grunt.registerTask('default', ['dart2js']);
};
