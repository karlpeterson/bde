# == Schema Information
#
# Table name: challenges
#
#  id         :integer          not null, primary key
#  name       :string
#  start_date :date
#  duration   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Challenge < ApplicationRecord
	has_many :datapoints
	has_many :cohorts
	has_many :users, :through => :cohorts
	accepts_nested_attributes_for :datapoints
end
