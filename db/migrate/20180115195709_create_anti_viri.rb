class CreateAntiViri < ActiveRecord::Migration[5.1]
  def change
    create_table :anti_viri do |t|
      t.references :teamowner, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
