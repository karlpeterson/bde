class AddUsersToChallenges < ActiveRecord::Migration[5.0]
  def change
  	create_table :users_challenges, id: false do |t|
  		t.belongs_to :users, index: true
  		t.belongs_to :challenges, index: true
  	end
  end
end
