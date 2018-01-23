class CreateCryptics < ActiveRecord::Migration[5.1]
  def change
    create_table :cryptics do |t|
      t.references :teamowner, foreign_key: true
      t.string :answer

      t.timestamps
    end
  end
end
