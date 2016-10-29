var gulp, sass, sourcemaps;

gulp = require('gulp');

sass = require('gulp-sass');

var coffee, coffeeFilter, filter, liveReload, sourceMaps, uglify;

sourceMaps = require("gulp-sourcemaps");

liveReload = require("gulp-livereload");

filter = require("gulp-filter");

coffee = require("gulp-coffee");

uglify = require("gulp-uglify");

coffeeFilter = filter(["**/*.coffee"]);

gulp.task("js", function() {
  var stream;
  stream = gulp.src("paths/to/your/js").pipe(sourceMaps.init()).pipe(coffeeFilter).pipe(coffee()).pipe(coffeeFilter.restore()).pipe(concat("../public/assets"));
  if (["production, staging"].indexOf(railsEnv) !== -1) {
    stream = stream.pipe(uglify());
  }
  return stream.pipe(gulp.dest("../public/assets")).pipe(sourceMaps.write(".")).pipe(liveReload());
});


gulp.task('default', ['compile-sass', 'compile-scss', 'fonts']);

gulp.task("fonts", function() {
  return gulp.src("fonts/**/*").pipe(gulp.dest("../public/assets/fonts/")).pipe(liveReload());
});

gulp.task('compile-sass', function() {
  gulp.src('app/assets/stylesheets/**/*.sass')
      .pipe(sourceMaps.init())
      .pipe(sass({ indentedSyntax: true, errLogToConsole: true }))
      .pipe(sourceMaps.write())
      .pipe(gulp.dest('public/assets'));
});

gulp.task('compile-scss', function() {
  gulp.src('app/assets/stylesheets/**/*.scss')
      .pipe(sourceMaps.init())
      .pipe(sass({ indentedSyntax: false, errLogToConsole: true }))
      .pipe(sourceMaps.write())
      .pipe(gulp.dest('public/assets'));
});
