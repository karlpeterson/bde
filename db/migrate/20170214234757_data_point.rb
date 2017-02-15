class DataPoint < ActiveRecord::Migration[5.0]
  def change
  	create_table :datapoints do |t|
  		t.belongs_to :user, index: true
  		t.belongs_to :challenge, index: true

  		t.date		:date
  		t.integer	:day
  		t.boolean	:data_0
  		t.boolean	:data_1
  		t.boolean	:data_2
  		t.boolean	:data_3
  		t.boolean	:data_4
  		t.boolean	:data_5
  		t.boolean	:data_6
  		t.boolean	:data_7
  		t.boolean	:data_8
  		t.boolean	:data_9
  		t.integer	:total_points

  		t.timestamps
  	end
  end
end
