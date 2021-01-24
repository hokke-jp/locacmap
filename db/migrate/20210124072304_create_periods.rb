class CreatePeriods < ActiveRecord::Migration[6.1]
  def change
    create_table :periods do |t|
      t.string :name

      t.timestamps
    end
  end
end
