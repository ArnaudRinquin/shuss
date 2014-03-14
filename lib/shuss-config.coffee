convict = require 'convict'

config = convict {
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
  livereload:
    doc: 'Enable livereload'
    default: false
    env: 'SHUSS_LR'
  livereloadport:
    doc: 'The livereload server port'
    default: 35729
    env: 'SHUSS_LR_PORT'
}

config.validate()

module.exports = config
