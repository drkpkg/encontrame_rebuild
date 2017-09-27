require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get user_login" do
    get api_user_login_url
    assert_response :success
  end

  test "should get user_create" do
    get api_user_create_url
    assert_response :success
  end

  test "should get publication_all" do
    get api_publication_all_url
    assert_response :success
  end

  test "should get publication_info" do
    get api_publication_info_url
    assert_response :success
  end

  test "should get publication_modify" do
    get api_publication_modify_url
    assert_response :success
  end

  test "should get publication_create" do
    get api_publication_create_url
    assert_response :success
  end

  test "should get publication_delete" do
    get api_publication_delete_url
    assert_response :success
  end

end
