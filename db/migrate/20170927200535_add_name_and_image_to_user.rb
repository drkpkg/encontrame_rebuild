class AddNameAndImageToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :photo_uid, :string
    add_column :users, :photo_name, :string
  end
end
