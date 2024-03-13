class SetDefaultToFavs < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :productos_fav, from: nil, to: {}
  end
end
