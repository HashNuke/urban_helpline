require 'test_helper'

class Admin::CallsControllerTest < ActionController::TestCase
  test "should get handle" do
    get :handle
    assert_response :success
  end

end
