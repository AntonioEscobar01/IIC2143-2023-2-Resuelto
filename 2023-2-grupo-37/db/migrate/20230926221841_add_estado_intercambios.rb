class AddEstadoIntercambios < ActiveRecord::Migration[7.0]
  def change
    add_column :intercambios, :estado, :string
    add_column :intercambios, :id_propietario, :integer
  end
end
