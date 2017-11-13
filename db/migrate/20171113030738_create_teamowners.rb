class CreateTeamowners < ActiveRecord::Migration[5.1]
  def change
    create_table :teamowners do |t|
      t.text :aboutme
      t.integer :seniority
      t.integer :age
      t.integer :education
      t.string :nick_name
      t.string :room
      t.string :phone
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
