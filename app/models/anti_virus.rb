class AntiVirus < ApplicationRecord
  belongs_to :teamowner, foreign_key: 'teamowner_id'
  belongs_to :post, optional: false
  validates :post_id, presence: true
end
