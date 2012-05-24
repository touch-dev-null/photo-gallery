class PhotosController < ApplicationController

  before_filter :authenticate_user!, :except => [:list, :show]

  def new

  end

end
