class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :verify_app_token

  respond_to :json

  def user_login
    user = User.find_by_email(params[:email])
    response = {}
    #Type NORMAL or FB
    if !user.nil?
      if params[:type] == 'NORMAL'
        if user.valid_password? params[:password]
          response = {
            email: user.email,
            photo: "#{request.base_url}#{user.photo.url}"
          }
          status = 200
        else
          status = 400
        end
      else
        status = 200
      end
    else
      status = 400
    end

    render json: {response: response}, status: status
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
    
    Publication.all.each do |publication|
      publications.push(
        {
          'id': publication.id,
          'name': publication.person_name,
          'title': publication.title,
          'photo': "#{request.base_url}#{publication.photo.url}",
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
    render json: {
      'id': publication.id,
      'name': publication.person_name,
      'title': publication.title,
      'photo': "#{request.base_url}#{publication.photo.url}",
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
    publication = Publication.find(params[:publication_id])
    publication.delete
    render json: {data: :ok}, status: :ok
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
