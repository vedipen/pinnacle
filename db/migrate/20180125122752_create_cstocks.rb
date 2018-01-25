class CreateCstocks < ActiveRecord::Migration[5.1]
  def change
    create_table :cstocks do |t|
      t.references :company, foreign_key: true
      t.integer :price

      t.timestamps
    end
  end
end
