class Company < ApplicationRecord
  belongs_to :user
  has_many :cstocks
  has_many :ostocks
end
