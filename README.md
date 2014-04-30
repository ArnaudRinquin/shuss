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
  -d, --dir          Served files directory                 [default: "."]
  -p, --port         Runs Shuss on the specified port       [default: "1234"]
  --verbose          Speak to me
  -l, --livereload   Enables LiveReload
  --livereload_port  Runs LiveReload on the specified port  [default: "35729"]
  -f, --file         Config file path
  -v, --version      Return actual Shuss version
  -h, --help         Displays Shuss help
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
$ > shuss -p 6543 --verbose -l --livereload_port 6523
info: serving /Users/romain/Projects/shuss on http://0.0.0.0:6543
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

## plugins

While being very simple, Shuss can handle complexe plugins.

### Using a plugin

To use a plugin, you will probably have to install them in the same scope as shuss. Chances are you must install them globaly:

```
npm i -G shuss-my-awesome-plugin
```

Then, you just have to specify the comma separated list of plugins you want to use, along with their own arguments. Here is an example with `shuss-basic-auth`

```
shuss --plugins basic-auth --username admin --password foobar
```

### Available plugins

* [shuss-basic-auth](https://github.com/ArnaudRinquin/shuss-basic-auth): basic HTTP auth plugin


### Writing a plugin

A plugin is a npm package prefixed by `shuss-`. Plugins can act on:

* the underlaying [Express](http://expressjs.com/) app,
* the [Express](http://expressjs.com/) object (i.e `require(express)`),
* the [convict](https://github.com/mozilla/node-convict) settings object

You are allowed to add your own cli args.

All they have to define is a `load(app, express, config)` function. See the [`basic-auth`](https://github.com/ArnaudRinquin/shuss-basic-auth/blob/master/lib/shuss-basic-auth.coffee) example.

## Development

All Shuss Node.js module are written in CoffeeScript.

In order to use correctly the `shuss` binary, you have to compile them in JavaScript.

It can be done through:

```bash
$ grunt coffee:compile
```

Or more easily:

```bash
$ grunt
```

## Todo

### Features

* test config solver, urgent, not how to do it yet, maybe [`node-env-file`](https://www.npmjs.org/package/node-env-file)
* any idea?

### Integration

So much to do!

* grunt-shuss
* gulp-shuss
* atom-shuss
* sublime-shuss
* younameit-shuss

## Contributing

[Contributors](https://github.com/ArnaudRinquin/shuss/graphs/contributors) and [CONTRIBUTING](https://github.com/ArnaudRinquin/shuss/blob/master/CONTRIBUTING.md)

## License

Released under the MIT License. See the [LICENSE](https://github.com/ArnaudRinquin/shuss/blob/master/LICENSE.md) file for further details.
