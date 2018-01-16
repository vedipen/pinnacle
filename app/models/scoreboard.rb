class Scoreboard < ApplicationRecord
  belongs_to :team, optional: true
  belongs_to :post, optional: true
  validates :team_id, presence: true
  validates :post_id, presence: true
  validates :currentscore, presence: true
end
