class Profile < ApplicationRecord
  belongs_to :user
  has_attached_file :image, styles: { medium: "700x500#", small: "350x250>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :about_me, presence: true
  validates :seniority, presence: true
  validates :age, presence: true
  validates :strengths, presence: true
  validates :weakness, presence: true
  validates :education, presence: true
  validates :nick_name, presence: true
  validates :image, presence: true
  validates :room, presence: true
  validates :phone, presence: true
end
