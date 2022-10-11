class ChangeDataTypeForBadgeTemplateId < ActiveRecord::Migration[7.0]
  def change
    change_table :badges do |t|
      t.change :badge_template_id, :string
    end 
  end
end
