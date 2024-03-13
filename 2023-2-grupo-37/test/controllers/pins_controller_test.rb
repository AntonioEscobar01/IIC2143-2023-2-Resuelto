require "test_helper"

class PinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pin = pins(:one)
  end

  test "Debería mostrar index" do
    get new_pin_url
    assert_response :success
  end

  test "Método create funciona" do
    assert_difference("Pin.count") do
      post pins_url, params: { pin: { title: @pin.title } }
    end

    assert_redirected_to pin_url(Pin.last)
  end

  #test "Método show funciona" do
  #  get pin_url(@pin)
  #  assert_response :success
  #end

  test "Método edit funciona" do
    get edit_pin_url(@pin)
    assert_response :success
  end

  test "Funciona método update" do
    patch pin_url(@pin), params: { pin: { title: @pin.title } }
    assert_redirected_to pin_url(@pin)
  end

  test "Método destroy destuye pin" do
    assert_difference("Pin.count", -1) do
      delete pin_url(@pin)
    end

    assert_redirected_to pins_url
  end
end
