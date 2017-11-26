class Teamowner < ApplicationRecord
  belongs_to :user
  has_attached_file :image, styles: { medium: "700x500#", small: "350x250>" }
  has_one :team
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :aboutme, presence: true
  validates :seniority, presence: true
  validates :age, presence: true
  validates :education, presence: true
  validates :nick_name, presence: true
  validates :room, presence: true
  validates :phone, presence: true
  validates :image, presence: true
end
