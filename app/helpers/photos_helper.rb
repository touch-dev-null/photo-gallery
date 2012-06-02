module PhotosHelper
  def link_to_photo(gallery, photo, photo_size = :mini)
    link_to user_gallery_photo_path(gallery.user, gallery, photo), :class => 'photo_preview', :remote => true, :rel => photo.identifier do
      image_tag(photo.photo.url(photo_size))
    end
  end
end
