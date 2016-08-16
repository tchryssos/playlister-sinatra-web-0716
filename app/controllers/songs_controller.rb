require 'pry'

class SongsController < ApplicationController

  get '/songs' do
    @songs=Song.all
    # binding.pry
    erb :'/songs/index'
  end



  post '/songs' do 
    # binding.pry
    @song = Song.create(name:params[:song][:name])

    artist = Artist.where("name LIKE ?", "%#{params[:song][:artist][:name]}")
    if artist.empty?
      Artist.create(name: params[:song][:artist][:name])
      @song.artist = artist.first
    else
      @song.artist = artist.first
    end
    @song.save
    # binding.pry
    if params[:song][:genres][:name] != [""]
      new_genre = Genre.create(name: params[:song][:genres][:name][0])

      @song.genres << new_genre

      @song.save
    end
      # binding.pry
      params[:song][:genres][:genre_ids].each do |genre_id|
        @song.genres << Genre.find(genre_id)
      end

    # binding.pry
    @song.save

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

    artist = Artist.where("name LIKE ?", "%#{params[:song][:artist][:name]}")
    if artist.empty?
      Artist.create(name: params[:song][:artist][:name])
      @song.artist = artist.first
    else
      @song.artist = artist.first
    end
    @song.save
    if params[:song][:genres][:name] != [""]
      new_genre = Genre.create(name: params[:song][:genres][:name][0])

      @song.genres << new_genre

      @song.save
    end
      # binding.pry
      params[:song][:genres][:genre_ids].each do |genre_id|
        @song.genres << Genre.find(genre_id)
      end

      @song.name = params[:song][:name]

      @song.save

    erb :"/songs/show"
  end

end
