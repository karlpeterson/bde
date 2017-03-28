class AddStatJoinTable < ActiveRecord::Migration[5.0]
  def change
  	create_table :stats do |t|
  		t.belongs_to :user, index: true
  		t.belongs_to :challenge, index: true

  		t.integer		:total_points

  		t.timestamps
  	end
  end
end
