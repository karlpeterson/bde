class AddRankingToStat < ActiveRecord::Migration[5.0]
  def change
  	change_table :stats do |t|
  		t.integer :rank
  	end
  end
end
