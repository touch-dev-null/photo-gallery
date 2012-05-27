class PhotosController < ApplicationController

  before_filter :authenticate_user!, :except => [:list, :show]

  def new
    @gallery  = Gallery.find(params[:gallery_id])
    @photo    = Photo.new()
  end

  def show
    @gallery  = Gallery.find(params[:id])
    @photos   = @gallery.photos
  end

  def create
    @gallery  = Gallery.find(params[:gallery_id])
    #binding.pry
    @photo  = @gallery.photos.build(params[:photo].merge!(:user_id => current_user.id))
    @photo.save ? redirect_to(user_gallery_path(current_user, @gallery)) : redirect_to(action => :new)
  end

end
