class AddHiddenTransactionsToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :hidden_transactions, :boolean, default: true
  end
end
