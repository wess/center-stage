ENV['RACK_ENV'] ||= 'development'

require 'rack/less'
require './app'

run <%= app_name %>::App