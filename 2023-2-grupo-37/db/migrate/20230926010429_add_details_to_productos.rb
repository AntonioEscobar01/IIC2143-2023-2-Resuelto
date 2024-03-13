class AddDetailsToProductos < ActiveRecord::Migration[7.0]
  def change
    add_column :productos, :estado, :string
    add_column :productos, :intercambiado, :boolean
  end
end
