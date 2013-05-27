require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get authenticate" do
    get :authenticate
    assert_response :success
  end

  test "should get callback" do
    get :callback
    assert_response :success
  end

  test "should get logout" do
    get :logout
    assert_response :success
  end

  test "should get stats" do
    get :stats
    assert_response :success
  end

end
