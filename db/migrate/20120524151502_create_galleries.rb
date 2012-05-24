class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer       :user_id, :null => false
      t.string        :name
      t.boolean       :hidden, :default=>false
      t.timestamps
    end
  end
end
