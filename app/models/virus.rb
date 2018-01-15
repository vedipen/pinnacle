class Virus < ApplicationRecord
  belongs_to :teamowner, foreign_key: 'teamowner_id'
  belongs_to :team, optional: false
  belongs_to :post, optional: false
  validates :team_id, presence: true
  validates :post_id, presence: true
end
