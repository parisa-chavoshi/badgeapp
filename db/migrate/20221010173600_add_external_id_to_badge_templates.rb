class AddExternalIdToBadgeTemplates < ActiveRecord::Migration[7.0]
  def change
    add_column :badge_templates, :external_id, :string
  end
end
