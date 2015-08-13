
module.exports = (grunt) ->

	grunt.initConfig
		sass:
			dist:
				files: [
					expand: true
					cwd: 'src/stylesheets/'
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
		browserify:
			dist:
				files: [
					'dist/js/bundle.js': 'src/scripts/main.es6'
				],
				options: {
					transform: [["babelify", { "stage": 0 }]],
					browserifyOptions:
						debug: true
				}
		clean:
			distCss:
				[ 'dist/css/' ]
			distJs:
				[ 'dist/js/' ]
		watch:
			scss:
				files: 'src/stylesheets/**/*.scss'
				tasks: ['clean:distCss', 'sass:dist', 'postcss:dist']
				options:
					spawn: false
			es6:
				files: 'src/scripts/**/*.es6'
				tasks: ['clean:distJs', 'browserify:dist']
				options:
					spawn: false

	# ===== LOAD

	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-sass'
	grunt.loadNpmTasks 'grunt-postcss'
	grunt.loadNpmTasks "grunt-browserify"

	grunt.registerTask 'default', [
		'clean'
		'sass'
		'postcss'
		'browserify'
		'watch'
	]
	grunt.registerTask 'build', [
		'clean:distCss', 'sass:dist', 'postcss:dist',
		'clean:distJs', 'babel:dist'
	]
