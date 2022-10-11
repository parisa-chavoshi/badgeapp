class CreateBadges < ActiveRecord::Migration[7.0]
  def change
    create_table :badges do |t|
      t.belongs_to :user
      t.belongs_to :badge_template
      
      t.timestamps
    end
  end
end
