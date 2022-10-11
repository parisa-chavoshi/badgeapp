class ChangeDataTypeForUserId < ActiveRecord::Migration[7.0]
  def change
    change_table :badges do |t|
      t.change :user_id, :string
    end 
  end
end
