require 'Rack'

module Task
	module Routes
		class Index < Sinatra::Application
			get '/?' do
				"Hello World"
			end
		end # /Index
	end # /Routes
end # /Index