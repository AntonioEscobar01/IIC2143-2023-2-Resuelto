require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @usuario_1 = users(:user_1)
    @usuario_2 = users(:user_2)
    @room = rooms(:one)

    sign_in @usuario_1
    sign_in @usuario_2
  end

  test "solo deben haber dos usuarios en la sala de chat" do
    @room.participants.create(user: @usuario_1)
    @room.participants.create(user: @usuario_2)

    get room_path(@room)
    assert_response :success
  end
end
