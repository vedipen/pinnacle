class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :name, presence: true
  validates :usertype, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
  has_many :companies
  has_many :comments
  has_one :profile
  has_many :cstocks
  has_many :ostocks
  has_many :bets
  has_one :teamowner
  has_one :pmcmember
end
