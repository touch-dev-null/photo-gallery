class CreateScheduledPhotos < ActiveRecord::Migration
  def change
    create_table :scheduled_photos do |t|
      t.integer     :gallery_id,  :null => false
      t.integer     :user_id,     :null => false
      t.string      :status
      t.string      :photo_path
      t.text        :log
      t.timestamps
    end

    add_index :scheduled_photos, :status
  end
end
