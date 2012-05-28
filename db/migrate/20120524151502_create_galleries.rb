class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer       :user_id, :null => false
      t.string        :name
      t.string        :url_name
      t.boolean       :hidden, :default=>false
      t.timestamps
    end

    add_index :galleries, :name
    add_index :galleries, :url_name
  end
end
