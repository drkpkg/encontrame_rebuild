class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :context
      t.references :user, foreign_key: true
      t.references :publication, foreign_key: true

      t.timestamps
    end
  end
end
