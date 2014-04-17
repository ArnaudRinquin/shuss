# shuss - super http u* static server [![NPM version](https://badge.fury.io/js/shuss.png)](http://badge.fury.io/js/shuss)

Super simple yet comprehensive static files server. Shuss :ski:

_u*:_ pick one
* uber
* unicorn
* universal
* ubuesque
* unix
* uhuhuh

## Installation

Shuss requires [`Node.js`](http://nodejs.org/) to run.

```shell
npm install shuss
```

You'd probably want it in available globally, with:

```shell
npm install -g shuss
```

### Livereload

To enjoy the pleasure of the livereload feature, just follow the official browser extension [installation guide](http://feedback.livereload.com/knowledgebase/articles/86242-how-do-i-install-and-use-the-browser-extensions-). Easy.

## Settings

Shuss loads settings in that order:

1. `defaults`
2. `env`
3. `-f <file>`
4. `cli args`

There are very few settings, all defaulted.

* port: `1234`
* dir: `'.'`
* livreload: `false`
* livereloadport: `35729`
* verbose: `false`

### CLI usage
```shell
$ > shuss -h
shuss [options...]

Options:
  -d, --dir         Served files directory            [default: "."]
  -p, --port        Runs Shuss on the specified port  [default: "1234"]
  --verbose         Speak to me
  -l, --livereload  Enables LiveReload
  -f, --file        Config file path
  -v, --version     Return actual Shuss version
  -h, --help        Displays Shuss help
```

Default usage:

```shell
$ > shuss
info: serving /Users/arnaud/projects/shuss on http://0.0.0.0:1234
```

Specific port and livereload (on default port):

```shell
$ > shuss -p 6543 -l
info: serving /Users/arnaud/projects/shuss on http://0.0.0.0:6543
```
Now with verbose, specified, port and livereload port

```shell
$ > shuss -p 6543 --verbose -l 6523
info: serving /Users/romain/Projects/shuss on http://0.0.0.0:6543
debug: starting server on port 6543
debug: starting livereload server on port 35729
```

### ENV variables

Shuss can load settings from these self-explanatory values:

* `SHUSS_PORT`
* `SHUSS_LR`
* `SHUSS_LR_PORT`
* `SHUSS_DIR`
* `SHUSS_VERBOSE`

### JSON File

You can specify a config file to load:
```
$ > shuss -f config.json
```

It is expected to contain json, like in this:
```
$ > cat config.json
{
  "port":8000,
  "livereload": true,
  "livereloadport": 9854,
  "verbose": true,
  "dir": "./public"
}
```

## todo

### features

* test config solver, urgent, not how to do it yet, maybe [`node-env-file`](https://www.npmjs.org/package/node-env-file)
* run as a daemon
* access to more config (livereload especially)
* any idea?

### integration

So much to do!

* grunt-shuss
* gulp-shuss
* atom-shuss
* sublime-shuss
* younameit-shuss

License
=======

MIT
