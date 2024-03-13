require "test_helper"

class AdminsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @usuario_random = users(:user_6)  
  end

  test "usuarios normales no tienen acceso a permisos del administrador" do
    sign_in @usuario_random
    get "/admin"
    assert_redirected_to root_path
    assert_equal "Access denied.", flash[:alert]
  end

end
