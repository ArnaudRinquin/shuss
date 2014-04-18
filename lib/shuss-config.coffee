convict = require 'convict'

config = convict {
  verbose:
    doc: 'Speak to me'
    default: false
  port:
    doc: 'Runs Shuss on the specified port'
    format: 'port'
    default: '1234'
    env: 'SHUSS_PORT'
  dir:
    doc: 'Served files directory'
    default: '.'
    env: 'SHUSS_DIR'
  livereload:
    doc: 'Enables LiveReload'
    default: false
    env: 'SHUSS_LR'
  livereload_port:
    doc: 'The LiveReload server port'
    default: 35729
    env: 'SHUSS_LR_PORT'
}

config.validate()

module.exports = config
