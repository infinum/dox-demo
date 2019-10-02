(function() {
  var PrettyError, aglio, cErr, cWarn, chokidar, clc, fs, getErrContext, getLineNo, http, logError, logWarnings, parser, path, serveStatic;

  aglio = require('./main');

  chokidar = require('chokidar');

  clc = require('cli-color');

  fs = require('fs');

  http = require('http');

  path = require('path');

  PrettyError = require('pretty-error');

  serveStatic = require('serve-static');

  parser = require('yargs').usage('Usage: $0 [options] -i infile [-o outfile -s]').example('$0 -i example.apib -o output.html', 'Render to HTML').example('$0 -i example.apib -s', 'Start preview server').example('$0 --theme-variables flatly -i example.apib -s', 'Theme colors').example('$0 --no-theme-condense-nav -i example.apib -s', 'Disable options').options('i', {
    alias: 'input',
    describe: 'Input file'
  }).options('o', {
    alias: 'output',
    describe: 'Output file'
  }).options('t', {
    alias: 'theme',
    describe: 'Theme name or layout file',
    "default": 'default'
  }).options('f', {
    alias: 'filter',
    boolean: true,
    describe: 'Sanitize input from Windows',
    "default": true
  }).options('s', {
    alias: 'server',
    describe: 'Start a local live preview server'
  }).options('h', {
    alias: 'host',
    describe: 'Address to bind local preview server to',
    "default": '127.0.0.1'
  }).options('p', {
    alias: 'port',
    describe: 'Port for local preview server',
    "default": 3000
  }).options('v', {
    alias: 'version',
    describe: 'Display version number',
    "default": false
  }).options('c', {
    alias: 'compile',
    describe: 'Compile the blueprint file',
    "default": false
  }).options('n', {
    alias: 'include-path',
    describe: 'Base directory for relative includes'
  }).options('verbose', {
    describe: 'Show verbose information and stack traces',
    "default": false
  }).epilog('See https://github.com/danielgtaylor/aglio#readme for more information');

  cErr = clc.white.bgRed;

  cWarn = clc.xterm(214).bgXterm(235);

  getErrContext = function(input, lineNo) {
    var context, inputLines;
    inputLines = input.split('\n');
    context = inputLines.slice(lineNo - 5, lineNo + 5);
    return context.map(function(line, index) {
      if (index === 4) {
        return cWarn(">>>>   " + line);
      } else {
        return "       " + line;
      }
    });
  };

  getLineNo = function(input, err) {
    if (err.location && err.location.length) {
      return input.substr(0, err.location[0].index).split('\n').length;
    }
  };

  logWarnings = function(warnings) {
    var errContext, i, len, lineNo, ref, results, warning;
    ref = warnings || [];
    results = [];
    for (i = 0, len = ref.length; i < len; i++) {
      warning = ref[i];
      lineNo = getLineNo(warnings.input, warning) || 0;
      errContext = getErrContext(warnings.input, lineNo);
      console.error(cWarn(">> Line " + lineNo + ":") + (" " + warning.message + " (warning code " + warning.code + ")"));
      console.error(cWarn(">> Context"));
      results.push(console.error("       ...\n " + (errContext.join('\n')) + " \n       ..."));
    }
    return results;
  };

  logError = function(err, verbose) {
    var pe;
    if (verbose) {
      pe = new PrettyError();
      pe.setMaxItems(5);
      return console.error(pe.render(err));
    } else {
      return console.error(cErr('>>'), err);
    }
  };

  exports.run = function(argv, done) {
    var _html, config, entry, err, getHtml, i, io, len, paths, ref, sendHtml, server, theme, watcher;
    if (argv == null) {
      argv = parser.argv;
    }
    if (done == null) {
      done = function() {};
    }
    _html = null;
    getHtml = function(cb) {
      if (_html) {
        return cb && cb(null, _html);
      } else {
        return fs.readFile(argv.i, "utf-8", function(err, blueprint) {
          console.log("Rendering " + argv.i);
          return aglio.render(blueprint, argv, function(err, html, warnings) {
            logWarnings(warnings);
            if (err) {
              logError(err, argv.verbose);
              return cb && cb(err);
            } else {
              _html = html;
              return cb && cb(null, _html);
            }
          });
        });
      }
    };
    if (argv.version) {
      console.log("aglio " + (require('../package.json').version));
      console.log("olio " + (require('aglio-theme-olio/package.json').version));
      return done();
    }
    if (argv.template) {
      argv.theme = argv.template;
    }
    if (fs.existsSync(argv.theme)) {
      argv.themeTemplate = argv.theme;
      argv.theme = 'default';
    }
    if (argv.verbose) {
      console.log("Loading theme " + argv.theme);
    }
    try {
      theme = aglio.getTheme(argv.theme);
    } catch (_error) {
      err = _error;
      err.message = "Could not load theme: " + err.message;
      logError(err, argv.verbose);
      return done(err);
    }
    config = theme.getConfig();
    ref = config.options;
    for (i = 0, len = ref.length; i < len; i++) {
      entry = ref[i];
      parser.options("theme-" + entry.name, entry);
    }
    if (argv.s) {
      if (!argv.i) {
        parser.showHelp();
        return done('Invalid arguments');
      }
      argv.locals = {
        livePreview: true
      };
      if (argv.i !== '-') {
        argv.includePath = path.dirname(argv.i);
      }
      getHtml();
      server = http.createServer(function(req, res) {
        var serve;
        if (req.url !== '/') {
          serve = serveStatic(path.dirname(argv.i));
          return serve(req, res, function() {
            return res.end();
          });
        }
        return getHtml(function(err, html) {
          res.writeHead(200, {
            "Content-Type": "text/html"
          });
          return res.end((err ? err.toString() : html));
        });
      }).listen(argv.p, argv.h, function() {
        return console.log("Server started on http://" + argv.h + ":" + argv.p + "/");
      });
      sendHtml = function(socket) {
        return getHtml(function(err, html) {
          var re;
          if (!err) {
            console.log("Refresh web page in browser");
            re = /<body.*?>[^]*<\/body>/gi;
            html = html.match(re)[0];
            return socket.emit("refresh", html);
          }
        });
      };
      io = require("socket.io")(server);
      io.on("connection", function(socket) {
        console.log("Socket connected");
        return socket.on('request-refresh', function() {
          return sendHtml(socket);
        });
      });
      paths = aglio.collectPathsSync(fs.readFileSync(argv.i, 'utf-8'), path.dirname(argv.i));
      watcher = chokidar.watch([argv.i].concat(paths));
      watcher.on("change", function(path) {
        console.log("Updated " + path);
        _html = null;
        return sendHtml(io);
      });
      return done();
    } else {
      if (!argv.i || !argv.o) {
        parser.showHelp();
        return done('Invalid arguments');
      }
      if (argv.c || (typeof argv.o === 'string' && (argv.o.match(/\.apib$/ || argv.o.match(/\.md$/))))) {
        return aglio.compileFile(argv.i, argv.o, function(err) {
          if (err) {
            logError(err, argv.verbose);
          }
          return done();
        });
      } else {
        return aglio.renderFile(argv.i, argv.o, argv, function(err, warnings) {
          var lineNo;
          if (err) {
            lineNo = getLineNo(err.input, err);
            if (lineNo != null) {
              console.error(cErr(">> Line " + lineNo + ":") + (" " + err.message + " (error code " + err.code + ")"));
            } else {
              logError(err, argv.verbose);
            }
            return done(err);
          }
          logWarnings(warnings);
          return done();
        });
      }
    }
  };

}).call(this);
