require 'test_helper'

class PublicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @publication = publications(:one)
  end

  test "should get index" do
    get publications_url
    assert_response :success
  end

  test "should get new" do
    get new_publication_url
    assert_response :success
  end

  test "should create publication" do
    assert_difference('Publication.count') do
      post publications_url, params: { publication: { age: @publication.age, approximate_age: @publication.approximate_age, clothing: @publication.clothing, contact_email: @publication.contact_email, contact_phone: @publication.contact_phone, date_of_disappearance: @publication.date_of_disappearance, height: @publication.height, nickname: @publication.nickname, person_name: @publication.person_name, photo_name: @publication.photo_name, photo_uid: @publication.photo_uid, sex: @publication.sex, structure: @publication.structure, title: @publication.title, weight: @publication.weight } }
    end

    assert_redirected_to publication_url(Publication.last)
  end

  test "should show publication" do
    get publication_url(@publication)
    assert_response :success
  end

  test "should get edit" do
    get edit_publication_url(@publication)
    assert_response :success
  end

  test "should update publication" do
    patch publication_url(@publication), params: { publication: { age: @publication.age, approximate_age: @publication.approximate_age, clothing: @publication.clothing, contact_email: @publication.contact_email, contact_phone: @publication.contact_phone, date_of_disappearance: @publication.date_of_disappearance, height: @publication.height, nickname: @publication.nickname, person_name: @publication.person_name, photo_name: @publication.photo_name, photo_uid: @publication.photo_uid, sex: @publication.sex, structure: @publication.structure, title: @publication.title, weight: @publication.weight } }
    assert_redirected_to publication_url(@publication)
  end

  test "should destroy publication" do
    assert_difference('Publication.count', -1) do
      delete publication_url(@publication)
    end

    assert_redirected_to publications_url
  end
end
