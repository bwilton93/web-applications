require 'sinatra/base'
require "sinatra/reloader"

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  post '/hello' do
    if invalid_name?
      status 400
      return erb(:index)
    end

    @name = params[:name]

    return erb(:hello)
  end

  def invalid_name?
    return true if params[:name].include?("<script>")
    return true if params[:name] == nil || params[:name] == ''
    return false
  end
end
