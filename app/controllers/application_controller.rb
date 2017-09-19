require 'cities'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_configs, :authenticate_user!#, except:[:index]
  
  def set_configs
    Cities.data_path = "#{Rails.root}/data/cities"
  end
end
