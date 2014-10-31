
### Rakefile for App Management and setup
require 'rubygems'
require 'rake'
require 'yaml'
require 'erb'

task :default => [:run]

def generate_from_template(item_name, directory)
	config 		= YAML.load(File.read('./config.yml'))
	file_name 	= item_name
	name 		= file_name.slice(0, 1).capitalize + file_name.slice(1..-1)
	app 		= config['app_name'].slice(0, 1).capitalize + config['app_name'].slice(1..-1)
	erb 		= ERB.new File.read("./.templates/#{directory}.rb.erb")

	File.open("./#{directory}/#{file_name}.rb", "w") do |f| 
		f.write erb.result(binding)
	end
end

namespace :generate do
	desc "Generate a new route"
	task :route, [:name] do |t, args|
		generate_from_template(args[:name], "routes")
	end

	desc "Generate a new model"
	task :model, [:name] do |t, args|
		generate_from_template(args[:name], "models")
	end
end

desc "Run app locally"
task :run => "Gemfile.lock" do

	sh "clear && bundle exec shotgun"

end
