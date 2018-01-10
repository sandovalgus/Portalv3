class CreateImports < ActiveRecord::Migration[5.1]
  def change
    create_table :imports do |t|
      t.boolean :state

      t.timestamps
    end
  end
end
