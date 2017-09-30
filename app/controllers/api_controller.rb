class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token  
  
  respond_to :json
  
  def user_login
    render json: {response: "Hola #{params[:nombre]}"}
  end

  def user_create
    user = User.new

    if params[:type]=='facebook'
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name 
      user.photo = auth.info.image
    else
      #Normal User
      user.email = params[:email]
      user.password = params[:password]
    end

    if user.save
      response = {status: :ok, message: 'Created!'}
    else
      response = {status: :bad_request, message: 'BOOM'}
    end
    #@user = User.new(params[:email], params[:password])
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
