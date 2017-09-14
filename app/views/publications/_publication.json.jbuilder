json.extract! publication, :id, :title, :person_name, :photo_uid, :photo_name, :date_of_disappearance, :age, :approximate_age, :height, :weight, :structure, :nickname, :clothing, :contact_email, :contact_phone, :sex, :created_at, :updated_at
json.url publication_url(publication, format: :json)
