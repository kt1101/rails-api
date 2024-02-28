class JobLocation < ApplicationRecord
  belongs_to :job, optional: true
  belongs_to :location, optional: true
end