class Author < ApplicationRecord
  has_many :books, dependent: :restrict_with_error
  
  scope :active, -> { where(active: true).order(:name) }
end
