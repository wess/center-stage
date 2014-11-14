require 'rubygems'
require 'json'
require 'bundler'
require 'data_mapper'

Bundler.require

require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/contrib/all'
require 'sinatra/reloader'

# Routes
Dir[File.dirname(__FILE__) + '/routes/*.rb'].each {|file| require file}

# Models
Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file}

# Config 


module <%= app_name %>
  class App < Sinatra::Base  
    set :root,        File.dirname(__FILE__)
    set :environment, ENV['RACK_ENV']

    settings = YAML.load(File.read('./config.yml'))

    configure :development do
      set :db, {
        user:     settings['development']['db']['user'],
        password: settings['development']['db']['password']  || '',
        host:     settings['development']['db']['host']      || 'localhost',
        port:     settings['development']['db']['port']      || 5432,
        name:     settings['development']['db']['name']
      }

      register Sinatra::Reloader
    end #/configure

    configure :production do
      set :db, {
        user:     settings['production']['db']['user'],
        password: settings['production']['db']['password']  || '',
        host:     settings['production']['db']['host']      || 'localhost',
        port:     settings['production']['db']['port']      || 5432,
        name:     settings['production']['db']['name']
      }
    end #/configure

    DataMapper.setup(:default, "postgres://#{db[:user]}:#{db[:password]}@#{db[:host]}:#{db[:port]}/#{db[:name]}")
    DataMapper.finalize
    DataMapper.auto_upgrade!

    enable :sessions
  
    register Sinatra::Namespace

    use Rack::Deflater
    use Routes::Index

    not_found do
      content_type :json
      halt 404, {error: 'File not found'}.to_json
    end
  end # /App
end # /<%= app_name %>





