class PhotosController < ApplicationController

  require 'fileutils'

  skip_before_filter :verify_authenticity_token, :only => [:upload_photo]

  before_filter :authenticate_user!, :except => [:list, :show, :find_by_identifier]

  def new
    @gallery  = Gallery.find_by_url_name(params[:gallery_id])
    @photo    = Photo.new()
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def find_by_identifier
    photo_identifier = params[:identifier][1..params[:identifier].length]

    begin
      @photo = Gallery.find_by_url_name(params[:gallery_id]).photos.where('identifier = ?', photo_identifier).first
    rescue
      @photo = Gallery.find_by_url_name(params[:gallery_id]).photos.first
    end

    respond_to do |format|
      format.js { render 'show' }
    end
  end

  def create
    @gallery  = Gallery.find_by_url_name(params[:gallery_id])
    @photo    = @gallery.photos.build(:photo => params['photo'], :user_id => User.first.id)
    @photo.save # ? redirect_to(user_gallery_path(current_user, @gallery)) : redirect_to(:action => :new)
    render :nothing => true
  end

  def upload_photo
    @gallery  = Gallery.find_by_url_name(params[:gallery_id])

    name      = params['photo'].original_filename
    directory = @gallery.directory_path
    Dir.mkdir(Rails.public_path + directory) unless File.directory?(Rails.public_path + directory)

    upload_path = File.join(Rails.public_path + directory, name)

    File.open(upload_path, "wb") { |f| f.write(params['photo'].read) }

    scheduled_photo = @gallery.scheduled_photos.build(:user_id    => current_user.id,
                                    :status     => 'pending',
                                    :photo_path => File.join(directory, name))

    scheduled_photo.save

    #binding.pry
    render :nothing => true
  end

  def destroy
    @photo = Photo.find(params[:id])
    @gallery = @photo.gallery

    #delete converted photos
    FileUtils.rm_rf(Rails.public_path + @gallery.directory_path + "/#{@photo.id}")
    #delete photo original
    FileUtils.rm_rf(Rails.public_path + @gallery.directory_path + "/#{@photo.photo_file_name}")

    @photo.destroy
    redirect_to user_gallery_path(current_user, @gallery)
  end

end
