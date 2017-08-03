module.exports = function(grunt) {
  var settings = grunt.file.readJSON("settings.json");

  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-contrib-cssmin');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.initConfig({
    less: {
      prod: {
         options: {
             cleancss: true
         },
         files: {"css/shan.css": "./css/less/shan.less"}
      }
    },
    watch: {
      scripts: {
        files: ['css/less/*.less'],
        tasks: ['less']
      }
    }
  });
};