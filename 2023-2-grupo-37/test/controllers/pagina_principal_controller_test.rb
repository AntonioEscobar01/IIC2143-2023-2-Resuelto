require "test_helper"

class PaginaPrincipalControllerTest < ActionDispatch::IntegrationTest
  test "Se debe acceder a la página principal sin problemas" do
    get pagina_principal_index_url
    assert_response :success
  end
end
