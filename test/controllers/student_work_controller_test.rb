require 'test_helper'

class StudentWorkControllerTest < ActionController::TestCase
  test "should get discipline_id:integer" do
    get :discipline_id:integer
    assert_response :success
  end

  test "should get name:string" do
    get :name:string
    assert_response :success
  end

end
