class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string    :login
      t.string    :password
      t.string    :salt
      t.string    :email
      t.boolean   :is_admin, :default=>false
      t.timestamps
    end
  end
end
