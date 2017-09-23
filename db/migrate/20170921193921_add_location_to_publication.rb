class AddLocationToPublication < ActiveRecord::Migration[5.1]
  def change
    add_column :publications, :location, :string
  end
end
