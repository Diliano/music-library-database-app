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

  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all

    return erb(:all_albums)
  end

  post '/albums' do
    if album_invalid_request_parameters?
      status 400

      return ""
    end
    
    repo = AlbumRepository.new

    new_album = Album.new
    new_album.title = params[:title]
    new_album.release_year = params[:release_year]
    new_album.artist_id = params[:artist_id]

    repo.create(new_album)
    
    return erb(:album_created)
  end

  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all
    
    return erb(:all_artists)
  end

  post '/artists' do
    if artist_invalid_request_parameters?
      status 400
      
      return ""
    end

    repo = ArtistRepository.new

    new_artist = Artist.new
    new_artist.name = params[:name]
    new_artist.genre = params[:genre]

    repo.create(new_artist)
    
    return erb(:artist_created)
  end

  get '/albums/new' do
    return erb(:create_album)
  end

  get '/artists/new' do
    return erb(:create_artist)
  end

  get '/albums/:id' do
    album_repo = AlbumRepository.new
    @album = album_repo.find(params[:id])

    artist_repo = ArtistRepository.new
    @artist = artist_repo.find(@album.artist_id)
    
    return erb(:find_album)
  end

  get '/artists/:id' do
    repo = ArtistRepository.new
    @artist = repo.find(params[:id])

    return erb(:find_artist)
  end

private 

def album_invalid_request_parameters?
  return true if params[:title] == nil || params[:release_year] == nil || params[:artist_id] == nil

  return true if params[:title] == "" || params[:release_year] == "" || params[:artist_id] == ""

  return false
end

def artist_invalid_request_parameters?
  return true if params[:name] == nil || params[:genre] == nil

  return true if params[:name] == "" || params[:genre] == ""

  return false
end

end