class Deal < ApplicationRecord
  belongs_to :company

  STATUSES = %i[lost won pending]
end
