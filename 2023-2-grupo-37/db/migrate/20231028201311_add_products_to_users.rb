class AddProductsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :productos_fav, :json
  end
end
