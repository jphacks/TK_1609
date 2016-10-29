"use strict";

var gulp = require('gulp');
var eslint = require('gulp-eslint');
var plumber = require('gulp-plumber');
var notifier = require('node-notifier');
var webpack = require('gulp-webpack');
var webpackConfig = require('./webpack.config.js');
var rimraf = require('rimraf');

// eslint タスク（一時チェック）
gulp.task('lint', function() {
  return gulp.src(['./src/**.js']) // lint のチェック先を指定
    .pipe(plumber({
      errorHandler: function(error) {
        var taskName = 'eslint';
        var title = '[task]' + taskName + ' ' + error.plugin;
        var errorMsg = 'error: ' + error.message;
        // ターミナルにエラーを出力
        console.error(title + '\n' + errorMsg);
        // エラーを通知
        notifier.notify({
          title: title,
          message: errorMsg,
          time: 3000
        });
      }
    }))
    .pipe(eslint({ useEslintrc: true })) // .eslintrc を参照
    .pipe(eslint.format())
    .pipe(eslint.failOnError())
    .pipe(plumber.stop());
});

gulp.task('cleanDist', function (cb) {
  rimraf('./dist/', cb);
});

gulp.task('copyIndex', ['cleanDist'], function () {
  return gulp.src('./src/index.html')
  .pipe(gulp.dest('./dist/'));
});

gulp.task('dist', ['copyIndex'], function (cb) {
  gulp.run('lint');
  return gulp.src('')
  .pipe(webpack(webpackConfig))
  .pipe(gulp.dest(''));
});

// ファイル監視
// ファイルに更新があったらビルドしてブラウザをリロードする
gulp.task('watch', function() {
  gulp.watch('./src/**', ['dist']);
});

gulp.task('default', ['lint'], function(){
    gulp.run('watch');
});
