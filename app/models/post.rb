class Post < ApplicationRecord
  acts_as_votable
  belongs_to :user
  has_many :comments
  has_many :hiddens
  has_many :viri
  has_many :anti_viri
  has_many :bets
  has_many :scoreboards
  has_attached_file :image, styles: { medium: "700x500#", small: "350x250>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :title, presence: true
  validates :duration, presence: true
  validates :description, presence: true
  validates :image, presence: true
end
