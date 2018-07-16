class Book < ApplicationRecord
  belongs_to :user

  validates :uuid,  presence: true, uniqueness: true
  validates :csv_name, presence: true
  
end
