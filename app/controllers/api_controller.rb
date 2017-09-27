class Api::ApiController < Api::BaseController
  include Devise::Controllers::InternalHelpers
    
  respond_to :json
  
  def user_login
    build_resource
    resource = User.find_for_database_authentication(:login=>params[:user_login][:login])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user_login][:password])
      sign_in("user", resource)
      render :json=> {:success=>true, :auth_token=>resource.authentication_token, :login=>resource.login, :email=>resource.email}
      return
    end
    invalid_login_attempt
  end

  def user_create
  end

  def publication_all
  end

  def publication_info
  end

  def publication_modify
  end

  def publication_create
  end

  def publication_delete
  end

  protected

  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end
end
