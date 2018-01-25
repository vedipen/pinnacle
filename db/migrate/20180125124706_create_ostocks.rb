class CreateOstocks < ActiveRecord::Migration[5.1]
  def change
    create_table :ostocks do |t|
      t.references :user, foreign_key: true
      t.integer :price

      t.timestamps
    end
  end
end
