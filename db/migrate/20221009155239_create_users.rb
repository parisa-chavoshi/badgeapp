class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :external_id
      t.string :name
      t.string :description
      t.string :thumbnail

      t.timestamps
    end
  end
end
