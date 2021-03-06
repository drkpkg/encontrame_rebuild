class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  dragonfly_accessor :photo do
    Rails.root.join('public', 'images', 'default.png') 
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.photo = auth.info.image # assuming the user model has an image
    end
  end
  
  def set_default_image
    self.photo =  ActionDispatch::Http::UploadedFile.new(:tempfile => File.new(File.open(Rails.root.join('public', 'images', 'default.png'))))
  end
end
