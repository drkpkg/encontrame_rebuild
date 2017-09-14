class CreatePublications < ActiveRecord::Migration[5.1]
  def change
    create_table :publications do |t|
      t.string :title
      t.string :person_name
      t.string :photo_uid
      t.string :photo_name
      t.date :date_of_disappearance
      t.integer :age
      t.boolean :approximate_age
      t.string :height
      t.string :weight
      t.string :structure
      t.string :nickname
      t.string :clothing
      t.string :contact_email
      t.string :contact_phone
      t.string :sex

      t.timestamps
    end
  end
end
