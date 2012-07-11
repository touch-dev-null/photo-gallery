class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :gallery

  serialize :exif

  attr_accessible :photo, :user_id, :photo_file_name, :photo_content_type, :photo_file_size, :width, :height, :exif

  #after_save :set_exif

  attr_reader :mini, :small, :medium, :large, :original

  PHOTO_OPTIONS = {
      :mini => {
          :geometry => '124x124',
          :quality => 85,
          :format => 'jpg'
      },
      :small => {
          :geometry => '160x160',
          :quality => 85,
          :format => 'JPG'
      },
      :thumb => {
          :geometry => '200x200',
          :quality => 100
      },
      :medium => {
          :geometry => '400x400',
          :quality => 100
      },
      :large => {
          :geometry => '800x700>',
          :quality => 100
      }
  }

  def url(size = :small)
    case size
      when :original
        "/uploads/galleries/#{self.gallery_id}/#{self.photo_file_name}"
      else
        "/uploads/galleries/#{self.gallery_id}/#{self.id}/#{size}/#{self.photo_file_name}"
    end
  end

  def generate_identifier
    self.identifier = (Digest::SHA1.hexdigest (self.photo_file_size + Time.now.to_i).to_s)[0..10]
  end

  def set_exif
    begin
      exif = EXIFR::JPEG.new(Rails.public_path + self.url(size = :original))
      photo_exif = {
        :make                       => exif.make,
        :model                      => exif.model,
        :software                   => exif.software,
        :date_time                  => exif.date_time,
        :exposure_time              => exif.exposure_time,
        :f_number                   => exif.f_number.to_f,
        :shutter_speed_value        => exif.shutter_speed_value,
        :aperture_value             => exif.aperture_value,
        :iso_speed_ratings          => exif.iso_speed_ratings,
        :focal_length               => exif.focal_length,
        :exposure_program           => exif.exposure_program,
        :date_time_original         => exif.date_time_original,
        :date_time_digitized        => exif.date_time_digitized,
        :white_balance              => exif.white_balance,
        :digital_zoom_ratio         => exif.digital_zoom_ratio,
        :focal_length_in_35mm_film  => exif.focal_length_in_35mm_film,
        :scene_capture_type         => exif.scene_capture_type,
        :gain_control               => exif.gain_control,
        :contrast                   => exif.contrast,
        :saturation                 => exif.saturation,
        :sharpness                  => exif.sharpness,
        :subject_distance_range     => exif.subject_distance_range
      }
      self.update_attribute(:exif, photo_exif)
    rescue => e
      return false
    end
  end

end
