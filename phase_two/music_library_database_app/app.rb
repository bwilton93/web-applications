# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end
  
  post '/albums' do
    if invalid_request_parameters?
      status 400
      return ''
    end
    title = params[:title]
    release_year = params[:release_year]

    new_album = Album.new
    new_album.title = title
    new_album.release_year = release_year

    AlbumRepository.new.create(new_album)

    return erb(:album_created)
  end

  def invalid_request_parameters?
    # nil params
    return true if params[:title] == nil || params[:release_year] == nil
    # empty string params
    return true if params[:title] == '' || params[:release_year] == ''

    return false
  end

  get '/albums' do
    repo = AlbumRepository.new
    
    @albums = repo.all

    return erb(:albums)
  end

  get '/albums/new' do
    return erb(:new_album)
  end
  
  get '/albums/:id' do
    album_repo = AlbumRepository.new
    @album = album_repo.find(params[:id])
    
    artist_repo = ArtistRepository.new
    @artist = artist_repo.find(@album.artist_id)

    return erb(:album)
  end

  get '/artists' do
    repo = ArtistRepository.new
    
    @artists = repo.all
    
    return erb(:artists)
  end

  get '/artists/:id' do
    repo = ArtistRepository.new
    
    @artist = repo.find(params[:id])
    
    return erb(:artist)
  end

  post '/artists' do
    repo = ArtistRepository.new
    artist = Artist.new

    artist.name = params[:name]
    artist.genre = params[:genre]

    repo.create(artist)
  end
end
