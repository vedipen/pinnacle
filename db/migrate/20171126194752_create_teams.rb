class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.text :about_team
      t.references :teamowner, foreign_key: true
      
      t.timestamps
    end
  end
end
