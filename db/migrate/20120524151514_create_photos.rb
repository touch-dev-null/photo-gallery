class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer     :gallery_id, :null => false
      t.integer     :user_id, :null => false
      t.string      :photo_file_name
      t.string      :photo_content_type
      t.integer     :photo_file_size
      t.datetime    :photo_updated_at
      t.timestamps
    end
  end
end
