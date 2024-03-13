class AddUserToProducto < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:productos, :user_id)
      add_reference :productos, :user, null: false, foreign_key: true
    end
  end
end
