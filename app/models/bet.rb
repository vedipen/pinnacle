class Bet < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :team, optional: false
  belongs_to :post, optional: false
  validates :team_id, presence: true
  validates :post_id, presence: true
end
