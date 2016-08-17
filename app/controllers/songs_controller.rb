require 'pry'

class SongsController < ApplicationController

  get '/songs' do
    @songs=Song.all
    erb :'/songs/index'
  end

  post '/songs' do 
    @song = Song.create(params[:song])

    if Artist.find_by(params[:artist]) == nil
      new_artist = Artist.create(params[:artist])
      @song.artist = new_artist
    else
      @song.artist = Artist.find_by(params[:artist])
    end

    @song.save
    if params[:genres][0][:name] != ""    
      @song.genres << Genre.create(params[:genres])
      @song.save
    end

    redirect "/songs/#{@song.slug}"

  end


  get '/songs/new' do 
    erb :'/songs/new'
  end


  get '/songs/:slug' do
    @song=Song.find_by_slug(params["slug"])
    erb :'/songs/show'
  end

  get '/songs/:slug/edit' do 
    @song = Song.find_by_slug(params["slug"])  
    erb :'/songs/edit'
  end


  patch '/songs/:slug' do 
    @song = Song.find_by_slug(params["slug"])

    # artist = Artist.where("name LIKE ?", "%#{params[:artist][:name]}") / if artist.empty?
    if Artist.find_by(params[:artist]) == nil
      new_artist = Artist.create(params[:artist])
      @song.artist = new_artist
    else
      @song.artist = Artist.find_by(params[:artist])
    end
    @song.save

    if params[:genres][0][:name] != ""
      new_genre = Genre.create(params[:genres])
      @song.genres << new_genre
      @song.save
    end

    @song.update(params[:song])
      # We don't need this anymore because params[:artists][genre_ids] automatically assigns the genres
      # params[:song][:genre_ids].each do |genre_id|
      #   @song.genres << Genre.find(genre_id)
      # end
      # @song.name = params[:song][:name]
      # @song.save

    erb :"/songs/show"
  end

end
