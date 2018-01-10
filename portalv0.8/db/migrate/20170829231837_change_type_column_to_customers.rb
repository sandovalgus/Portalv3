class ChangeTypeColumnToCustomers < ActiveRecord::Migration[5.1]
  def up
    change_table :customers do |t|
      t.change :estado, :integer
    end
  end
 
  def down
    change_table :customers do |t|
      t.change :estado, :string
    end
  end
end
