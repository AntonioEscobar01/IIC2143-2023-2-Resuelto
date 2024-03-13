require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  include ApplicationHelper

  test "Se retornan estrellas correctas para calificación positiva" do
    assert_equal '⭐⭐⭐⭐⭐', star_rating(5)
    assert_equal '⭐⭐⭐⭐', star_rating(4.5)
    assert_equal '⭐⭐⭐⭐', star_rating(4)
    assert_equal '⭐⭐⭐', star_rating(3.5)
    assert_equal '⭐⭐⭐', star_rating(3)
  end

  test "Se retorna 'Sin estrellas' para calificación no positiva" do
    assert_equal 'Sin estrellas', star_rating(0)
    assert_equal 'Sin estrellas', star_rating(-2)
  end
end