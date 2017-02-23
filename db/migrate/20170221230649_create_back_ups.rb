class CreateBackUps < ActiveRecord::Migration[5.0]
  def change
    create_table :back_ups do |t|
      t.json 'jsonData'
      t.timestamps
    end
  end
end
