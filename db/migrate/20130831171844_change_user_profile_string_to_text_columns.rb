class ChangeUserProfileStringToTextColumns < ActiveRecord::Migration
  def up
    change_column :user_profiles, :about2030, :text, limit: nil
    change_column :user_profiles, :avatar_file_name, :text, limit: nil
    change_column :user_profiles, :education, :text, limit: nil
    change_column :user_profiles, :employer, :text, limit: nil
    change_column :user_profiles, :profession, :text, limit: nil
  end

  def down
    change_column :user_profiles, :about2030, :string
    change_column :user_profiles, :avatar_file_name, :string
    change_column :user_profiles, :education, :string
    change_column :user_profiles, :employer, :string
    change_column :user_profiles, :profession, :string
  end
end
