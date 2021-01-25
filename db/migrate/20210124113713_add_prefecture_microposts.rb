class AddPrefectureMicroposts < ActiveRecord::Migration[6.1]
  def change
    add_reference :microposts, :prefecture, foreign_key: true
  end
end
