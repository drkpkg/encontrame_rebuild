class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :verify_app_token

  respond_to :json
  
  def user_login
    user = User.find(id: params[:id])
    #if params[:type] != 'fb'
    #  user.
    #end

    render json: {response: :ok}, status: :ok
  end

  def user_create
    user = User.new

    if params[:type]=='facebook'
      user.email = params[:email]
      user.password = Devise.friendly_token[0,20]
      user.name = params[:name]
      user.photo = params[:image]
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
    publications = Publication.all
    render json: {data: publications}, status: :ok
  end

  def publication_info
    publication = Publication.find(id: params[:id])
    render json: {data: publication}, status: :ok
  end

  def publication_modify
    publication = Publication.find(id: params[:id])
    if publication.update(publication_params)
      status = :ok
    else
      status = :not_modified
    end
    render json: {data: publication}, status: status
  end

  def publication_create
    publication = Publication.new(publication_params)
    if publication.save
      render json: {data: :ok}, status: :ok  
    else
      render json: {data: :bad_request}, status: :bad_request
    end
  end

  def publication_delete
    publication = Publication.find(id: params[:id])
    publication.delete
    render json: {data: :ok}, status: :ok
  end

  protected

  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success => false, :message => "Error with your login or password"}, status: 401
  end

  def verify_app_token
    if params[:token].nil?
       render json: {message: 'Forbidden'}, status: :unauthorized
    end
  end

  private

  def publication_params
    params.require(:publication).permit(
      :title, 
      :person_name, 
      :photo, 
      :date_of_disappearance, 
      :age, 
      :approximate_age, 
      :height, 
      :weight, 
      :structure, 
      :nickname, 
      :clothing, 
      :contact_email, 
      :contact_phone, 
      :sex)
  end
end
