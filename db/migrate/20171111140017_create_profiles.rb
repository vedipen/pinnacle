class CreateProfile < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.text :about_me
      t.text :strengths
      t.text :weakness
      t.integer :seniority
      t.integer :age
      t.string :education
      t.string :nick_name

      t.timestamps
    end
  end
end
