ENV['RACK_ENV'] ||= 'development'

require './app'

run <%= app_name %>::App