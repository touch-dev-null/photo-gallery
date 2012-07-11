module PhotosHelper
  def link_to_photo(gallery, photo, photo_size = :mini)
    link_to user_gallery_photo_path(gallery.user, gallery, photo), :class => 'photo_preview', :remote => true, :rel => photo.identifier do
      image_tag(photo.url(photo_size))
    end
  end

  def photo_exif(photo)
    # available exif attributes :
    # :software, :make, :date_time, :exposure_time, :f_number, :shutter_speed_value, :aperture_value
    # :iso_speed_ratings, :focal_length, :exposure_program, :date_time_original, :date_time_digitized
    # :white_balance, :digital_zoom_ratio, :focal_length_in_35mm_film, :scene_capture_type, :gain_control
    # :contrast, :saturation, :sharpness, :subject_distance_range

    exif_attrs = {
        t('exif.model')               => :model,
        t('exif.exposure_time')       => :exposure_time,
        t('exif.f_number')            => :f_number,
        t('exif.date_time_original')  => :date_time_original
    }

    html_dl = ''
    exif_attrs.each do |label, attr|
      html_dl << content_tag(:dt, label)
      html_dl << content_tag(:dd, photo.exif[attr])
    end
    return content_tag(:dl, html_dl.html_safe)
  end
end
