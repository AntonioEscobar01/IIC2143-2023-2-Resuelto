class CalificarUsuario < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :calificacion, :integer, default: 0
  end
end
