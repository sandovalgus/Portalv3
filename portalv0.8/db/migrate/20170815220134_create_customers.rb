class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :n_socio
      t.string :nombre
      t.string :apellido

      t.timestamps
    end
  end
end
