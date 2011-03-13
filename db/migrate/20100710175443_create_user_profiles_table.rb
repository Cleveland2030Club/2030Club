class CreateUserProfilesTable < ActiveRecord::Migration
  def self.up
    create_table :user_profiles do |t|
      t.references :user
      t.string    :phone_number
			t.string    :profession			  	  
			t.string    :employer
			t.string    :education
 			t.string    :about2030
      	
      t.date 			:birthdate
      t.text 			:bio
      t.string 		:avatar_file_name
      t.string 		:avatar_content_type
      t.integer 	:avatar_file_size
      t.datetime	:avatar_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :user_profiles
  end
end
