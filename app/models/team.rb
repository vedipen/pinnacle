class Team < ApplicationRecord
  belongs_to :teamowner, foreign_key: 'teamowner_id'
  has_many :profiles
end
