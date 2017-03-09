class AddChallengesToUsers < ActiveRecord::Migration[5.0]
  def change
  	create_table :challenges_users, id: false do |t|
  		t.belongs_to :challenges, index: true
  		t.belongs_to :users, index: true
  	end
  end
end
