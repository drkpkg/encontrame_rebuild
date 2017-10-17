require 'json'

def create_records object_list, model
    object_list.map do |item|
        puts "Creando #{item}"
        object = model.new(item)
        object.save
        puts object.errors.full_messages
    end    
end

User.new(email: "user@gmail.com", password: "strange!").save

users = JSON.parse(File.read("#{Rails.root}/db/backup/users.json"))
publications = JSON.parse(File.read("#{Rails.root}/db/backup/publications.json"))

create_records users, User
create_records publications, Publication