class Scoreboard < ApplicationRecord
  belongs_to :team, optional: true
  validates :team_id, presence: true
  validates :currentscore, presence: true
end
