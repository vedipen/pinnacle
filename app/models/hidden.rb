class Hidden < ApplicationRecord
  belongs_to :teamowner, foreign_key: 'teamowner_id'
end
