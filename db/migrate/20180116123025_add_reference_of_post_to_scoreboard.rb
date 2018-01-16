class AddReferenceOfPostToScoreboard < ActiveRecord::Migration[5.1]
  def change
    add_reference :scoreboards, :post, foreign_key: true
  end
end
