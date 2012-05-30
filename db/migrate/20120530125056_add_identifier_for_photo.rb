class AddIdentifierForPhoto < ActiveRecord::Migration
  def up
    add_column :photos, :identifier, :string

    add_index :photos, :identifier
  end

  def down
    remove_column :photos, :identifier
  end
end
