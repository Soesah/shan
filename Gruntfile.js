module.exports = function(grunt) {
  var settings = grunt.file.readJSON("settings.json");

  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-contrib-cssmin');
  grunt.loadNpmTasks('grunt-contrib-clean');

  grunt.initConfig({
    less: {
      prod: {
         options: {
             cleancss: true
         },
         files: {"css/shan.css": "css/shan.less"}
      }
    }
  });
};