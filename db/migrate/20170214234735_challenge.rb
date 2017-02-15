class Challenge < ActiveRecord::Migration[5.0]
  def change
  	create_table :challenges do |t|
  		t.string		:name
  		t.date			:start_date
  		t.integer		:duration

  		t.timestamps
  	end
  end
end
