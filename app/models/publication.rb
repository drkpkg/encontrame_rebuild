class Publication < ApplicationRecord
    dragonfly_accessor :photo
    validates_uniqueness_of :person_name
    validates_presence_of :person_name
    has_many :comments

    def sex_humanize
        return "Hombre" if self.sex.eql? 'male'
        return "Mujer" if self.sex.eql? 'female'
    end
end
