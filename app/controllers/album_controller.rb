class AlbumController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]

  def index
    @albums = Album.all
  end

  def create
    @album = Album.new(params[:travel_id])
    if @album.save
      redirect_to @album
    else
      render action: "new"
    end
  end

  def new
    @album = Album.new
  end

  def edit
    @album = Album.find(params[:id])
    return redirect_to album_path(params[:id])
  end

  def show
    @album = Album.find(params[:id])
  end

  def update
    album_params = params.require(:album_params).permit(:title,:travel_id)
    @album = Album.find(params[:id])
    if @album.update_attributes(album_params)
      redirect_to @album
    else
      render action: "edit"
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to album_url
  end

end
