(function() {
  var aglio, assert, bin, blueprint, drafter, fs, http, path, root, sinon,
    indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  aglio = require('../lib/main');

  assert = require('assert');

  bin = require('../lib/bin');

  fs = require('fs');

  http = require('http');

  path = require('path');

  drafter = require('drafter');

  sinon = require('sinon');

  root = path.dirname(__dirname);

  blueprint = fs.readFileSync(path.join(root, 'example.apib'), 'utf-8');

  describe('API Blueprint Renderer', function() {
    it('Should load the default theme', function() {
      var theme;
      theme = aglio.getTheme('default');
      return assert.ok(theme);
    });
    it('Should get a list of included files', function() {
      var input, paths;
      sinon.stub(fs, 'readFileSync', function() {
        return 'I am a test file';
      });
      input = '# Title\n<!-- include(test1.apib) -->\nSome content...\n<!-- include(test2.apib) -->\nMore content...';
      paths = aglio.collectPathsSync(input, '.');
      fs.readFileSync.restore();
      assert.equal(paths.length, 2);
      assert(indexOf.call(paths, 'test1.apib') >= 0);
      return assert(indexOf.call(paths, 'test2.apib') >= 0);
    });
    it('Should render blank string', function(done) {
      return aglio.render('', {
        template: 'default',
        locals: {
          foo: 1
        }
      }, function(err, html) {
        if (err) {
          return done(err);
        }
        assert(html);
        return done();
      });
    });
    it('Should render a complex document', function(done) {
      return aglio.render(blueprint, 'default', function(err, html) {
        if (err) {
          return done(err);
        }
        assert(html);
        assert(html.indexOf('This is content that was included'));
        return done();
      });
    });
    it('Should render mixed line endings and tabs properly', function(done) {
      var temp;
      temp = '# GET /message\r\n+ Response 200 (text/plain)\r\r\t\tHello!\n';
      return aglio.render(temp, 'default', done);
    });
    it('Should render a custom template by filename', function(done) {
      var template;
      template = path.join(root, 'test', 'test.jade');
      return aglio.render('# Blueprint', template, function(err, html) {
        if (err) {
          return done(err);
        }
        assert(html);
        return done();
      });
    });
    it('Should return warnings with filtered input', function(done) {
      var filteredTemp, temp;
      temp = '# GET /message\r\n+ Response 200 (text/plain)\r\r\t\tHello!\n';
      filteredTemp = temp.replace(/\r\n?/g, '\n').replace(/\t/g, '    ');
      return aglio.render(temp, 'default', function(err, html, warnings) {
        if (err) {
          return done(err);
        }
        assert.equal(filteredTemp, warnings.input);
        return done();
      });
    });
    it('Should render from/to files', function(done) {
      var dest, src;
      src = path.join(root, 'example.apib');
      dest = path.join(root, 'example.html');
      return aglio.renderFile(src, dest, {}, done);
    });
    it('Should render from stdin', function(done) {
      sinon.stub(process.stdin, 'read', function() {
        return '# Hello\n';
      });
      setTimeout(function() {
        return process.stdin.emit('readable', 1);
      });
      return aglio.renderFile('-', 'example.html', 'default', function(err) {
        if (err) {
          return done(err);
        }
        assert(process.stdin.read.called);
        process.stdin.read.restore();
        process.stdin.removeAllListeners();
        return done();
      });
    });
    it('Should render to stdout', function(done) {
      sinon.stub(console, 'log');
      return aglio.renderFile(path.join(root, 'example.apib'), '-', 'default', function(err) {
        if (err) {
          console.log.restore();
          return done(err);
        }
        assert(console.log.called);
        console.log.restore();
        return done();
      });
    });
    it('Should compile from/to files', function(done) {
      var dest, src;
      src = path.join(root, 'example.apib');
      dest = path.join(root, 'example-compiled.apib');
      return aglio.compileFile(src, dest, done);
    });
    it('Should compile from stdin', function(done) {
      sinon.stub(process.stdin, 'read', function() {
        return '# Hello\n';
      });
      setTimeout(function() {
        return process.stdin.emit('readable', 1);
      });
      return aglio.compileFile('-', 'example-compiled.apib', function(err) {
        if (err) {
          return done(err);
        }
        assert(process.stdin.read.called);
        process.stdin.read.restore();
        process.stdin.removeAllListeners();
        return done();
      });
    });
    it('Should compile to stdout', function(done) {
      sinon.stub(console, 'log');
      return aglio.compileFile(path.join(root, 'example.apib'), '-', function(err) {
        if (err) {
          return done(err);
        }
        assert(console.log.called);
        console.log.restore();
        return done();
      });
    });
    it('Should support legacy theme names', function(done) {
      return aglio.render('', {
        template: 'flatly'
      }, function(err, html) {
        if (err) {
          return done(err);
        }
        assert(html);
        return done();
      });
    });
    it('Should error on missing input file', function(done) {
      return aglio.renderFile('missing', 'output.html', 'default', function(err, html) {
        assert(err);
        return aglio.compileFile('missing', 'output.apib', function(err) {
          assert(err);
          return done();
        });
      });
    });
    it('Should error on bad template', function(done) {
      return aglio.render(blueprint, 'bad', function(err, html) {
        assert(err);
        return done();
      });
    });
    it('Should error on drafter failure', function(done) {
      sinon.stub(drafter, 'parse', function(content, options, callback) {
        return callback('error');
      });
      return aglio.render(blueprint, 'default', function(err, html) {
        assert(err);
        drafter.parse.restore();
        return done();
      });
    });
    it('Should error on file read failure', function(done) {
      sinon.stub(fs, 'readFile', function(filename, options, callback) {
        return callback('error');
      });
      return aglio.renderFile('foo', 'bar', 'default', function(err, html) {
        assert(err);
        fs.readFile.restore();
        return done();
      });
    });
    it('Should error on file write failure', function(done) {
      sinon.stub(fs, 'writeFile', function(filename, data, callback) {
        return callback('error');
      });
      return aglio.renderFile('foo', 'bar', 'default', function(err, html) {
        assert(err);
        fs.writeFile.restore();
        return done();
      });
    });
    return it('Should error on non-file failure', function(done) {
      sinon.stub(aglio, 'render', function(content, template, callback) {
        return callback('error');
      });
      return aglio.renderFile(path.join(root, 'example.apib'), 'bar', 'default', function(err, html) {
        assert(err);
        aglio.render.restore();
        return done();
      });
    });
  });

  describe('Executable', function() {
    it('Should print a version', function(done) {
      sinon.stub(console, 'log');
      return bin.run({
        version: true
      }, function(err) {
        assert(console.log.args[0][0].match(/aglio \d+/));
        assert(console.log.args[1][0].match(/olio \d+/));
        console.log.restore();
        return done(err);
      });
    });
    it('Should render a file', function(done) {
      sinon.stub(console, 'error');
      sinon.stub(aglio, 'renderFile', function(i, o, t, callback) {
        var warnings;
        warnings = [
          {
            code: 1,
            message: 'Test message',
            location: [
              {
                index: 0,
                length: 1
              }
            ]
          }
        ];
        warnings.input = 'test';
        return callback(null, warnings);
      });
      bin.run({}, function(err) {
        return assert(err);
      });
      return bin.run({
        i: path.join(root, 'example.apib'),
        o: '-'
      }, function() {
        console.error.restore();
        aglio.renderFile.restore();
        return done();
      });
    });
    it('Should compile a file', function(done) {
      sinon.stub(aglio, 'compileFile', function(i, o, callback) {
        return callback(null);
      });
      return bin.run({
        c: 1,
        i: path.join(root, 'example.apib'),
        o: '-'
      }, function() {
        aglio.compileFile.restore();
        return done();
      });
    });
    it('Should start a live preview server', function(done) {
      this.timeout(5000);
      sinon.stub(aglio, 'render', function(i, t, callback) {
        return callback(null, 'foo');
      });
      sinon.stub(http, 'createServer', function(handler) {
        return {
          listen: function(port, host, cb) {
            var req, res;
            console.log('calling listen');
            req = {
              url: '/favicon.ico'
            };
            res = {
              end: function(data) {
                return assert(!data);
              }
            };
            handler(req, res);
            req = {
              url: '/'
            };
            res = {
              writeHead: function(status, headers) {
                return false;
              },
              end: function(data) {
                var file;
                aglio.render.restore();
                cb();
                file = fs.readFileSync('example.apib', 'utf8');
                return setTimeout(function() {
                  fs.writeFileSync('example.apib', file, 'utf8');
                  return setTimeout(function() {
                    console.log.restore();
                    return done();
                  }, 500);
                }, 500);
              }
            };
            return handler(req, res);
          }
        };
      });
      sinon.stub(console, 'log');
      sinon.stub(console, 'error');
      return bin.run({
        s: true
      }, function(err) {
        console.error.restore();
        assert(err);
        return bin.run({
          i: path.join(root, 'example.apib'),
          s: true,
          p: 3000,
          h: 'localhost'
        }, function(err) {
          assert.equal(err, null);
          return http.createServer.restore();
        });
      });
    });
    it('Should support custom Jade template shortcut', function(done) {
      sinon.stub(console, 'log');
      return bin.run({
        i: path.join(root, 'example.apib'),
        t: 'test.jade',
        o: '-'
      }, function(err) {
        console.log.restore();
        return done(err);
      });
    });
    it('Should handle theme load errors', function(done) {
      sinon.stub(console, 'error');
      sinon.stub(aglio, 'getTheme', function() {
        throw new Error('Could not load theme');
      });
      return bin.run({
        template: 'invalid'
      }, function(err) {
        console.error.restore();
        aglio.getTheme.restore();
        assert(err);
        return done();
      });
    });
    return it('Should handle rendering errors', function(done) {
      sinon.stub(aglio, 'renderFile', function(i, o, t, callback) {
        return callback({
          code: 1,
          message: 'foo',
          input: 'foo bar baz',
          location: [
            {
              index: 1,
              length: 1
            }
          ]
        });
      });
      sinon.stub(console, 'error');
      return bin.run({
        i: path.join(root, 'example.apib'),
        o: '-'
      }, function() {
        assert(console.error.called);
        console.error.restore();
        aglio.renderFile.restore();
        return done();
      });
    });
  });

}).call(this);
