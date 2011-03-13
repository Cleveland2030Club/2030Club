class CreateRegistrations < ActiveRecord::Migration
  def self.up
    create_table :registrations do |t|
      t.references :user
      t.string    :email,               :null => false                # optional, you can use login instead, or both
      t.string    :first_name,          :null => false
      t.string    :last_name,           :null => false
	    t.string    :address
	    t.string    :address2
	    t.string    :city
			t.string    :state
			t.string    :zip
			t.string    :phone_number
			t.string    :profession			  	  
			t.string    :employer
			t.string    :education
 			t.string    :about2030

      t.timestamps
    end
  end

  def self.down
    drop_table :registrations
  end
end
