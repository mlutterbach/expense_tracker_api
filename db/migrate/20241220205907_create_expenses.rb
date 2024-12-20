class CreateExpenses < ActiveRecord::Migration[7.2]
  def change
    create_table :expenses do |t|
      t.float :amount, null: false
      t.string :category, null: false
      t.text :description
      t.datetime :date, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
