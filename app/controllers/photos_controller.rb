class PhotosController < ApplicationController

  before_filter :authenticate_user!, :except => [:list, :show]

  def new
    @gallery  = Gallery.find_by_url_name(params[:gallery_id])
    @photo    = Photo.new()
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def create
    @gallery  = Gallery.find_by_url_name(params[:gallery_id])
    @photo  = @gallery.photos.build(params[:photo].merge!(:user_id => current_user.id))
    @photo.save ? redirect_to(user_gallery_path(current_user, @gallery)) : redirect_to(action => :new)
  end

  def destroy
    @photo = Photo.find(params[:id])
    @gallery = @photo.gallery
    @photo.destroy
    redirect_to user_gallery_path(current_user, @gallery)
  end

end
