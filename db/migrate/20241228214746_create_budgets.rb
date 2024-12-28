class CreateBudgets < ActiveRecord::Migration[7.2]
  def change
    create_table :budgets do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :amount, null: false, precision: 10, scale: 2
      t.string :month, null: false

      t.timestamps
    end

    add_index :budgets, [:user_id, :month], unique: true
  end
end
