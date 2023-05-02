require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end

  get '/hello' do
    name = params[:name] # The value is 'David'
  
    # Do something with `name`...
  
    return "Hello #{name}."
  end

  post '/submit' do
    name = params[:name]
    message = params[:message]

    return "Hello #{name}, you sent this message: #{message}"
  end

  post '/sort-names' do
    names = params[:names]
    names = names.split(',').sort
    return names.join(',')
  end
end
