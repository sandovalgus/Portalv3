class AddZoneToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_reference :customers, :zone, foreign_key: true
  end
end
