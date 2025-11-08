class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :year, presence: true, numericality: { only_integer: true }, inclusion: { in: 1900..2030 }
end
