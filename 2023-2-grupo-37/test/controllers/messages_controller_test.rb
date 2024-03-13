require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @usuario = users(:user_1)
    sign_in @usuario
    @room = rooms(:one)
    @room.save
  end

  test "debe crear mensajes en la sala de chat" do
    @usuario.save
    assert_difference('Message.count') do
      post room_messages_url(room_id: @room.id), params: { message: { body: "Hola Mundo" ,
        room_id: @room.id} }
    end
  end
end

