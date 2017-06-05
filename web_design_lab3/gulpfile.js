"use strict"

const gulp = require('gulp');
const autoprefixer = require('gulp-autoprefixer');


//html
gulp.task('html', function() {
  return gulp.src('./app/**/*.html')
    .pipe(connect.reload());
});

/* scss */
const sass = require('gulp-sass');

gulp.task('scss', () => {
  return gulp.src(`./scss/main.scss`)
    .pipe(sass().on('error', sass.logError))
    .pipe(gulp.dest(`./app/css/`))
    .pipe(connect.reload());
});


/* js */
gulp.task('js', function() {
  return gulp.src('./app/**/*.js')
    .pipe(connect.reload());
});


//connect server
var connect = require('gulp-connect');

gulp.task('connect', function() {
  connect.server({
    root: 'app',
    livereload: true,
    port: 8080
  });
});


//watch
gulp.task('watch', function() {
  gulp.watch(['./app/**/*.html'], ['html']);
  gulp.watch(['./app/**/*.js'], ['js']);
  gulp.watch(['./scss/**/*.scss'], ['scss']);
});

//default
gulp.task('default', ['connect', 'html', 'scss', 'js', 'watch']);