class CreateErpPopupsPopups < ActiveRecord::Migration[5.1]
  def change
    create_table :erp_popups_popups do |t|
      t.string :name
      t.text :content
      t.string :status
      t.integer :custom_order
      t.references :creator, index: true, references: :erp_users

      t.timestamps
    end
  end
end
