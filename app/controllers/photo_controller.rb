class PhotoController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :destroy]

  def index
    @photos = Photo.all
  end

  def create
    photo_params = params.require(:photo).permit(:user_id,:album_id,:image,:comment)
    @photo = Photo.new(photo_params)
    if @photo.save
      redirect_to @photo
    else
      render action: "new"
    end
  end

  def new
    @photo = Photo.new
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to photo_url
  end
end
