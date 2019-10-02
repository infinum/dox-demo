(function() {
  var INCLUDE, LEGACY_TEMPLATES, ROOT, benchmark, drafter, errMsg, fs, includeDirective, includeReplace, path,
    indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  fs = require('fs');

  path = require('path');

  drafter = require('drafter');

  INCLUDE = /( *)<!-- include\((.*)\) -->/gmi;

  ROOT = path.dirname(__dirname);

  LEGACY_TEMPLATES = ['default', 'default-collapsed', 'flatly', 'flatly-collapsed', 'slate', 'slate-collapsed', 'cyborg', 'cyborg-collapsed'];

  benchmark = {
    start: function(message) {
      if (process.env.BENCHMARK) {
        return console.time(message);
      }
    },
    end: function(message) {
      if (process.env.BENCHMARK) {
        return console.timeEnd(message);
      }
    }
  };

  errMsg = function(message, err) {
    err.message = message + ": " + err.message;
    return err;
  };

  includeReplace = function(includePath, match, spaces, filename) {
    var content, fullPath, lines;
    fullPath = path.join(includePath, filename);
    lines = fs.readFileSync(fullPath, 'utf-8').replace(/\r\n?/g, '\n').split('\n');
    content = spaces + lines.join("\n" + spaces);
    return includeDirective(path.dirname(fullPath), content);
  };

  includeDirective = function(includePath, input) {
    return input.replace(INCLUDE, includeReplace.bind(this, includePath));
  };

  exports.collectPathsSync = function(input, includePath) {
    var paths;
    paths = [];
    input.replace(INCLUDE, function(match, spaces, filename) {
      var content, fullPath;
      fullPath = path.join(includePath, filename);
      paths.push(fullPath);
      content = fs.readFileSync(fullPath, 'utf-8');
      return paths = paths.concat(exports.collectPathsSync(content, path.dirname(fullPath)));
    });
    return paths;
  };

  exports.getTheme = function(name) {
    if (!name || indexOf.call(LEGACY_TEMPLATES, name) >= 0) {
      name = 'olio';
    }
    return require("aglio-theme-" + name);
  };

  exports.render = function(input, options, done) {
    var filteredInput, ref, variables;
    if (typeof options === 'string' || options instanceof String) {
      options = {
        theme: options
      };
    }
    if (options.filterInput == null) {
      options.filterInput = true;
    }
    if (options.includePath == null) {
      options.includePath = process.cwd();
    }
    if (options.theme == null) {
      options.theme = 'default';
    }
    if (options.template) {
      options.theme = options.template;
    }
    if (fs.existsSync(options.theme)) {
      console.log("Setting theme to olio and layout to " + options.theme);
      options.themeLayout = options.theme;
      options.theme = 'olio';
    } else if (options.theme !== 'default' && (ref = options.theme, indexOf.call(LEGACY_TEMPLATES, ref) >= 0)) {
      variables = options.theme.split('-')[0];
      console.log("Setting theme to olio and variables to " + variables);
      options.themeVariables = variables;
      options.theme = 'olio';
    }
    input = includeDirective(options.includePath, input);
    filteredInput = !options.filterInput ? input : input.replace(/\r\n?/g, '\n').replace(/\t/g, '    ');
    benchmark.start('parse');
    return drafter.parse(filteredInput, {
      type: 'ast'
    }, function(err, res) {
      var f, i, len, name, option, ref1, theme, words;
      benchmark.end('parse');
      if (err) {
        err.input = input;
        return done(errMsg('Error parsing input', err));
      }
      try {
        theme = exports.getTheme(options.theme);
      } catch (_error) {
        err = _error;
        return done(errMsg('Error getting theme', err));
      }
      ref1 = theme.getConfig().options || [];
      for (i = 0, len = ref1.length; i < len; i++) {
        option = ref1[i];
        words = (function() {
          var j, len1, ref2, results;
          ref2 = option.name.split('-');
          results = [];
          for (j = 0, len1 = ref2.length; j < len1; j++) {
            f = ref2[j];
            results.push(f[0].toUpperCase() + f.slice(1));
          }
          return results;
        })();
        name = "theme" + (words.join(''));
        if (options[name] == null) {
          options[name] = option["default"];
        }
      }
      benchmark.start('render-total');
      return theme.render(res.ast, options, function(err, html) {
        benchmark.end('render-total');
        if (err) {
          return done(err);
        }
        res.warnings.input = filteredInput;
        return done(null, html, res.warnings);
      });
    });
  };

  exports.renderFile = function(inputFile, outputFile, options, done) {
    var render;
    render = function(input) {
      return exports.render(input, options, function(err, html, warnings) {
        if (err) {
          return done(err);
        }
        if (outputFile !== '-') {
          return fs.writeFile(outputFile, html, function(err) {
            return done(err, warnings);
          });
        } else {
          console.log(html);
          return done(null, warnings);
        }
      });
    };
    if (inputFile !== '-') {
      if (options.includePath == null) {
        options.includePath = path.dirname(inputFile);
      }
      return fs.readFile(inputFile, {
        encoding: 'utf-8'
      }, function(err, input) {
        if (err) {
          return done(errMsg('Error reading input', err));
        }
        return render(input.toString());
      });
    } else {
      process.stdin.setEncoding('utf-8');
      return process.stdin.on('readable', function() {
        var chunk;
        chunk = process.stdin.read();
        if (chunk != null) {
          return render(chunk);
        }
      });
    }
  };

  exports.compileFile = function(inputFile, outputFile, done) {
    var compile;
    compile = function(input) {
      var compiled;
      compiled = includeDirective(path.dirname(inputFile), input);
      if (outputFile !== '-') {
        return fs.writeFile(outputFile, compiled, function(err) {
          return done(err);
        });
      } else {
        console.log(compiled);
        return done(null);
      }
    };
    if (inputFile !== '-') {
      return fs.readFile(inputFile, {
        encoding: 'utf-8'
      }, function(err, input) {
        if (err) {
          return done(errMsg('Error writing output', err));
        }
        return compile(input.toString());
      });
    } else {
      process.stdin.setEncoding('utf-8');
      return process.stdin.on('readable', function() {
        var chunk;
        chunk = process.stdin.read();
        if (chunk != null) {
          return compile(chunk);
        }
      });
    }
  };

}).call(this);
