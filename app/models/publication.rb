class Publication < ApplicationRecord
    dragonfly_accessor :photo do
        Rails.root.join('public', 'images', 'default.png') 
    end
    validates_uniqueness_of :person_name
    validates_presence_of :person_name
    has_many :comments

    validates_presence_of :person_name, :age, :height, :weight, :date_of_disappearance
    
    def sex_humanize
        return "Hombre" if self.sex.eql? 'male'
        return "Mujer" if self.sex.eql? 'female'
    end

    def set_default_image
        self.photo =  ActionDispatch::Http::UploadedFile.new(:tempfile => File.new(File.open(Rails.root.join('public', 'images', 'default.png'))))
    end
end
