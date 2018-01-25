class CreateHeadlines < ActiveRecord::Migration[5.1]
  def change
    create_table :headlines do |t|
      t.string :title
      t.string :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
