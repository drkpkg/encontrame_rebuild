class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :verify_app_token

  respond_to :json

  def user_login
    user = User.find_by_email(params[:email])
    response = {message: "El usuario o contraseña es inválido"}
    #Type NORMAL or FB
    if !user.nil?
      if params[:type] == 'NORMAL'
        if user.valid_password? params[:password]
          if user.photo_stored? 
            photo_url = "#{request.base_url}#{user.photo.url}" 
          else
            photo_url = "#{request.base_url}/assets/default.png"
          end
          response = {
            email: user.email,
            photo: photo_url
          }
        end
      end
    end
 
    render json: {response: response}, status: :ok
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
    publications = Array.new
    filter = Hash.new
    filter[:id] = (params[:from]..params[:to]) if params[:from] and params[:to]
    filter[:user_id] = params[:user_id] if params[:user_id]
    
    publications_obj = Publication.where(filter)
    publications_obj.each do |publication|
      
      if publication.photo_stored? 
        photo_url = "#{request.base_url}#{publication.photo.url}" 
      else
        photo_url = "#{request.base_url}/assets/default.png"
      end

      publications.push(
        {
          'id': publication.id,
          'name': publication.person_name,
          'title': publication.title,
          'photo': photo_url,
          'date': publication.date_of_disappearance,
          'age': publication.age,
          'sex': publication.sex_humanize,
          'structure': publication.structure,
          'clothing': publication.clothing,
          'email': publication.contact_email,
          'phone': publication.contact_phone
        } 
      )
    end
    render json: {data: publications}, status: :ok
  end

  def publication_info
    publication = Publication.find(params[:publication_id])
    if publication.photo_stored? 
      photo_url = "#{request.base_url}#{publication.photo.url}" 
    else 
      photo_url = "#{asset_url 'default.png'}"
    end
    render json: {
      'id': publication.id,
      'name': publication.person_name,
      'title': publication.title,
      'photo': photo_url,
      'date': publication.date_of_disappearance,
      'age': publication.age,
      'sex': publication.sex_humanize,
      'structure': publication.structure,
      'clothing': publication.clothing,
      'email': publication.contact_email,
      'phone': publication.contact_phone}, 
      status: :ok
  end

  def publication_modify
    publication = Publication.find(params[:publication_id])
    if publication.update(publication_params)
      status = 200
    else
      status = 301
    end
    render json: {data: publication}, status: status
  end

  def publication_create
    publication = Publication.new(publication_params)
    if publication.save
      render json: {data: {message: 'Se guardo la publicacion'}}, status: :ok
    else
      render json: {data: {message: 'No se puede guardar la publicacion'}}, status: :bad_request
    end
  end

  def publication_delete
    publication = Publication.find(params[:publication_id])
    if publication.delete
      render json: {data: 200}, status: :ok
    else
      render json: {data: 400}, status: :bad_request
    end
  end

  protected

  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success => false, :message => "Error with your login or password"}, status: 401
  end

  def verify_app_token
    if params[:token] != 'LHIuovDZqiz7d8pwYaoHGGkzTBHdQReH'
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
