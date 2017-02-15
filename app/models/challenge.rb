class Challenge < ApplicationRecord::Base
	has_many :datapoints
	has_many :users, through: :datapoints
end