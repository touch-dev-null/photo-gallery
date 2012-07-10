class AddPhotoDimensions < ActiveRecord::Migration
  def up
    add_column :photos, :width, :integer
    add_column :photos, :height, :integer
  end

  def down
    remove_column :photos, :width
    remove_column :photos, :height
  end
end
