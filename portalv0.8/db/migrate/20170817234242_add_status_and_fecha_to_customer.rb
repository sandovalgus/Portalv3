class AddStatusAndFechaToCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :estado, :string
  	add_column :customers, :fecha_vencimiento, :date
  end
end

