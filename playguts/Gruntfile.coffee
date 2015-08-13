
module.exports = (grunt) ->

	grunt.initConfig
		sass:
			dist:
				files: [
					expand: true
					cwd: 'assets/stylesheets/'
					src: ['**/*.scss']
					dest: 'dist/css/'
					ext: '.css'
				]
		postcss:
			options:
				map: true,
				processors: [
					require('autoprefixer-core')({
						browsers: ['last 5 versions', '> 1%', 'IE 9'],
						cascade: false
					}),
					require("postcss-color-rgba-fallback")(),
					require('pixrem')('10px', {
						atrules: true
					})
				]
			dist:
				src: ['dist/css/**/*.css']
		babel:
			dist:
				files: [
					expand: true
					cwd: 'assets/scripts/'
					src: ['**/*.es6']
					dest: 'dist/js/'
					ext: '.js'
				]
		clean:
			distCss:
				[ 'dist/css/' ]
			distJs:
				[ 'dist/js/' ]
		watch:
			scss:
				files: 'assets/stylesheets/**/*.scss'
				tasks: ['clean:distCss', 'sass:dist', 'postcss:dist']
				options:
					spawn: false
			es6:
				files: 'assets/scripts/**/*.es6'
				tasks: ['clean:distJs', 'babel:dist']
				options:
					spawn: false

	# ===== LOAD

	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-sass'
	grunt.loadNpmTasks 'grunt-postcss'
	grunt.loadNpmTasks 'grunt-babel'

	grunt.registerTask 'default', [
		'clean'
		'sass'
		'postcss'
		'babel'
		'watch'
	]
	grunt.registerTask 'build', [
		'clean:distCss', 'sass:dist', 'postcss:dist',
		'clean:distJs', 'babel:dist'
	]
