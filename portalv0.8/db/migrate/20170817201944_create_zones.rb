class CreateZones < ActiveRecord::Migration[5.1]
  def change
    create_table :zones do |t|
      t.string :nombre_zona
      t.string :color

      t.timestamps
    end
  end
end
