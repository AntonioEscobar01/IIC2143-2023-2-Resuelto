require "test_helper"

class ProductoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "No deberia guardar producto sin nombre" do
    @producto = productos(:producto_2)
    resultado = @producto.save
    assert_not resultado
  end

  test "No deberia guardar producto sin categoria" do
    @producto = productos(:producto_3)
    resultado = @producto.save
    assert_not resultado
  end

  test "no existen productos duplicados" do
    @producto_n1 = productos(:producto_1)
    @producto_n2 = productos(:producto_5)
    assert_not_equal @producto_n1, @producto_n2
  end
 

end
