class AddPeriodMicroposts < ActiveRecord::Migration[6.1]
  def change
    add_reference :microposts, :period, foreign_key: true
  end
end
