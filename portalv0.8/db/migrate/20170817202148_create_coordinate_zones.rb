class CreateCoordinateZones < ActiveRecord::Migration[5.1]
  def change
    create_table :coordinate_zones do |t|
      t.float :latitud
      t.float :longitud
      t.references :zone, foreign_key: true

      t.timestamps
    end
  end
end
