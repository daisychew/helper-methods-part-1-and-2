class CreateDirectors < ActiveRecord::Migration[7.0]
  def change
    create_table :directors do |t|
      t.string :name
      t.date :date_of_birth
      t.text :bio

      t.timestamps
    end
  end
end
