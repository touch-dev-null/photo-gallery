require File.expand_path('config/environment.rb')

class Photos < Thor
  desc "update_dimensions", "Update dimensions of all photos"
  def update_dimensions
    Photo.find_each(:batch_size => 5 ) do |photo|
      begin
        image = MiniMagick::Image.open(Rails.public_path + photo.url(size = :original))
        photo.update_attributes(:width => image[:width], :height => image[:height])
        puts "Success updated Photo #{photo.id} - #{photo.width} x #{photo.height}"
      rescue
        puts "Not found Photo id #{photo.id}"
      end
    end
  end
end