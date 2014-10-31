ENV['RACK_ENV'] ||= 'development'

require 'rack/less'
require './app'

use Rack::Less,
	:root 		 => File.dirname(__FILE__),
	:source 	  => 'public/less',
	:hosted_at	=> '/stylesheets'

run Task::App