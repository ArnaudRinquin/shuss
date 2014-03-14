convict = require 'convict'

config = convict {
  env:
    doc: 'The application environment.'
    default: 'development'
    env: 'NODE_ENV'
  verbose:
    doc: 'speak to me'
    default: false
  port:
    doc: 'Listened port'
    format: 'port'
    default: '1234'
    env: 'SHUSS_PORT'
  dir:
    doc: 'Served file directory'
    default: '.'
    env: 'SHUSS_DIR'
  livereloadport:
    doc: 'Enable livereload'
    default: 35729
    env: 'SHUSS_LR'
  livereload:
    doc: 'The livereload server port'
    default: false
    env: 'SHUSS_LR_PORT'
}

config.validate()

module.exports = config
