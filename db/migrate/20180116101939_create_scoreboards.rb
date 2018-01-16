class CreateScoreboards < ActiveRecord::Migration[5.1]
  def change
    create_table :scoreboards do |t|
      t.references :team, foreign_key: true
      t.integer :currentscore, default: 0

      t.timestamps
    end
  end
end
