class AddEndDateToChallenges < ActiveRecord::Migration[5.0]
  def change
  	change_table :challenges do |t|
  		t.date :end_date
  		t.remove :duration
  	end
  end
end
