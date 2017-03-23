class Cohort < ApplicationRecord
	belongs_to :user, inverse_of: :cohorts
	belongs_to :challenge, inverse_of: :cohorts
end
