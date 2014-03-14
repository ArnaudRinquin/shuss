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

  Usage: shuss [options] [command]

  Commands:

    start [port]

  Options:

    -h, --help               output usage information
    -V, --version            output the version number
    -d, --dir <value>        served files directory
    -v, --verbose            speak to me
    -f, --file <path>        configuration file
    -l, --livereload [port]  enable livereload, optionnaly give a port
```

Default usage:

```shell
$ > shuss
info: serving /Users/arnaud/projects/shuss on http://0.0.0.0:1234
```

Specific port and livereload (on default port):

```shell
$ > shuss 6543 -l
info: serving /Users/arnaud/projects/shuss on http://0.0.0.0:6543
```
Now with verbose, specified, port and livereload port

```shell
$ > shuss start 6543 -v -l 6523
debug: config {
  "verbose": true,
  "port": 6543,
  "dir": ".",
  "livereload": true,
  "livereloadport": 6523
}
info: serving /Users/arnaud/projects/shuss on http://0.0.0.0:6543
debug: starting server on port 6543
debug: starting livereload server on port 6523
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
