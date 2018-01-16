class Team < ApplicationRecord
  belongs_to :teamowner, foreign_key: 'teamowner_id'
  has_many :profiles
  has_one :pmcmember
  has_many :hiddens
  has_many :bets
  has_attached_file :image, styles: { medium: "700x500#", small: "350x250>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
