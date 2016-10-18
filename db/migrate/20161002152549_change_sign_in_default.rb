class ChangeSignInDefault < ActiveRecord::Migration
  def change
  	change_column_default(:users, :sign_in_count, 1)
  end
end
