class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :gallery

  attr_accessible :photo, :user_id

  before_save :generate_identifier

  has_attached_file :photo,
                    :styles => {
                        :mini => {
                            :geometry => '124x124#',
                            :quality => 85,
                            :format => 'JPG'
                        },
                        :small => {
                            :geometry => '160x160#',
                            :quality => 85,
                            :format => 'JPG'
                        },
                        :thumb => {
                            :geometry => '200x200#',
                            :quality => 100
                        },
                        :medium => {
                            :geometry => '400x400>',
                            :quality => 100
                        },
                        :large => {
                            :geometry => '35%',
                            :quality => 100
                        },
                        :original => {
                            :geometry => '2000x2000',
                            :quality => 100
                        }
                    }

  def resize(min_width, min_height)
    geo = Paperclip::Geometry.from_file(photo.to_file(:original))

    ratio = geo.width/geo.height

    min_width  = min_width#142
    min_height = min_height#119

    if ratio > 1
      # Horizontal Image
      final_height = min_height
      final_width  = final_height * ratio
      "#{final_width.round}x#{final_height.round}!"
    else
      # Vertical Image
      final_width  = min_width
      final_height = final_width * ratio
      "#{final_height.round}x#{final_width.round}!"
    end
  end

  private

  def generate_identifier
    self.identifier = (Digest::SHA1.hexdigest (self.photo_file_size + Time.now.to_i).to_s)[0..10]
  end

end
