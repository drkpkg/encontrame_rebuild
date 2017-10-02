require 'cities'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_configs, :authenticate_user!, 
      except:[:user_login, :user_create, :publication_all, :publication_info, :publication_modify, :publication_create, :publication_delete]
  
  def set_configs
    Cities.data_path = "#{Rails.root}/data/cities"
  end
end
