class CreateHiddens < ActiveRecord::Migration[5.1]
  def change
    create_table :hiddens do |t|
      t.string :team_name
      t.string :event_name
      t.integer :amount
      t.references :teamowner, foreign_key: true

      t.timestamps
    end
  end
end
