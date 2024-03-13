class AddDefaultVisitasToProductos < ActiveRecord::Migration[6.0]
  def change
    change_column :productos, :visitas, :integer, default: 0
  end
end
