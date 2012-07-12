class GalleriesController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]

  def show
    @gallery  = Gallery.find_by_url_name(params[:id])
    @photos   = @gallery.photos
    @scheduled_photos = @gallery.scheduled_photos.pending.count
  end

  def new
    @new_gallery = Gallery.new()
  end

  def edit
    @gallery  = Gallery.find_by_url_name(params[:id])
  end

  def destroy
    @gallery  = Gallery.find_by_url_name(params[:id])


    FileUtils.rm_rf(Rails.public_path + @gallery.directory_path)
    @gallery.photos.destroy_all
    @gallery.destroy
    redirect_to root_path
  end

  def create
    @new_gallery = current_user.galleries.build(params[:gallery])
    if @new_gallery.save
      redirect_to user_gallery_path(current_user, @new_gallery)
    else
      render :action => 'new', :controller => 'galleries'
    end
  end
end
