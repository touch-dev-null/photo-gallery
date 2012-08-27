module PhotosHelper
  def link_to_photo(gallery, photo, photo_size = :mini)
    link_to user_gallery_photo_path(gallery.user, gallery, photo), :class => 'photo_preview', :remote => true, :rel => photo.identifier do
      image_tag(photo.url(photo_size))
    end
  end

  def photo_exif(photo)
    return 'No photo EXIF' if photo.exif.blank?

    # available exif attributes :
    # :software, :make, :date_time, :exposure_time, :f_number, :shutter_speed_value, :aperture_value
    # :iso_speed_ratings, :focal_length, :exposure_program, :date_time_original, :date_time_digitized
    # :white_balance, :digital_zoom_ratio, :focal_length_in_35mm_film, :scene_capture_type, :gain_control
    # :contrast, :saturation, :sharpness, :subject_distance_range

    exif_attrs = {
        t('exif.model')                 => :model,
        t('exif.exposure_time')         => :exposure_time,
        t('exif.f_number')              => :f_number,
        t('exif.iso')                   => :iso_speed_ratings,
        t('exif.focal_length')               => :focal_length,
        t('exif.focal_length_in_35mm_film')  => :focal_length_in_35mm_film,
        t('exif.date_time_original')    => :date_time_original
    }

    html = ''

    exif_attrs.each do |label, attr|
      next if photo.exif[attr].blank? || photo.exif[attr].to_s.eql?('0.0')

      html << content_tag(:dt, label)
      html << content_tag(:dd, photo.exif[attr])
    end
    return html.blank? ? '' : (t('exif.photo_information') + content_tag(:dl, html.html_safe)).html_safe
  end
end
