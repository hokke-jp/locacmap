class AddLatlngToMicroposts < ActiveRecord::Migration[6.1]
  def change
    add_column :microposts, :latlng, :string
  end
end
