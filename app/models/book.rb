class Book < ApplicationRecord
  belongs_to :author, optional: true
  
  validates :title, presence: true
  validates :year, presence: true, numericality: { only_integer: true }, inclusion: { in: 1900..2030 }
end
