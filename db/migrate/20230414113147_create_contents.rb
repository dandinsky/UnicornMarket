class CreateContents < ActiveRecord::Migration[7.0]
  def change
    create_table :contents do |t|
      t.string :titolo
      t.text :descrizione
      t.decimal :prezzo

      t.timestamps
    end
  end
end
