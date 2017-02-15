class DataPoint < ApplicationRecord::Base
	belongs_to :user
	belongs_to :challenge
end
