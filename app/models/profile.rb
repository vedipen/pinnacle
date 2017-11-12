class Profile < ApplicationRecord
  belongs_to :user
  validates :about_me, presence: true
  validates :seniority, presence: true
  validates :age, presence: true
  validates :strengths, presence: true
  validates :weakness, presence: true
  validates :education, presence: true
  validates :nick_name, presence: true
end
