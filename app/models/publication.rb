class Publication < ApplicationRecord
    dragonfly_accessor :photo
    validates_uniqueness_of :person_name
    validates_presence_of :person_name

end
