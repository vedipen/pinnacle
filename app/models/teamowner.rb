class Teamowner < ApplicationRecord
  belongs_to :user
  validates :aboutme, presence: true
  validates :seniority, presence: true
  validates :age, presence: true
  validates :education, presence: true
  validates :nick_name, presence: true
  validates :room, presence: true
  validates :phone, presence: true
end
