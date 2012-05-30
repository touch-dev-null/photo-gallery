class AddIdentifierForPhoto < ActiveRecord::Migration
  def up
    add_column :photos, :identifier, :string
  end

  def down
    remove_column :photos, :identifier
  end
end
