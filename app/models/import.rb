class Import < ApplicationRecord
  belongs_to :user

  enum :status, { pending: "pending", processing: "processing", completed: "completed", failed: "failed" }
end
