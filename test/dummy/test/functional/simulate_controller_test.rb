require 'test_helper'

class SimulateControllerTest < ActionController::TestCase
  test "should get tokenized_thing" do
    get :tokenized_thing
    assert_response :success
  end

end
