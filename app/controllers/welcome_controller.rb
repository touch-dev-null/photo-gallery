class WelcomeController < ApplicationController
  def index

    if gallery_single_mode?
      @galleries = Gallery.all#User.first.blank? ? nil : User.first.galleries
    end
  end
end
