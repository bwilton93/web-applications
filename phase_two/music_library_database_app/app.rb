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
    repo = AlbumRepository.new
    album = Album.new

    album.title = params[:title]
    album.release_year = params[:release_year]
    album.artist_id = params[:artist_id]

    repo.create(album)
    return
  end

  get '/albums' do
    repo = AlbumRepository.new
    
    @albums = repo.all

    return erb(:albums)
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
    
    artists = []
    results = repo.all
    
    results.each do |result|
      artist_name = result.name
      artists << artist_name
    end

    return artists.join(", ")
  end

  post '/artists' do
    repo = ArtistRepository.new
    artist = Artist.new

    artist.name = params[:name]
    artist.genre = params[:genre]

    repo.create(artist)
  end
end
