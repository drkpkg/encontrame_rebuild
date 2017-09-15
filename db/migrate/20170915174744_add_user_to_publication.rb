class AddUserToPublication < ActiveRecord::Migration[5.1]
  def change
    add_column :publications, :user_id, :integer, foreign_key: true
  end
end
