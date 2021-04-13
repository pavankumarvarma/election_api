class CreateElections < ActiveRecord::Migration[6.1]
  def change
    create_table :elections do |t|
      t.string :name
      t.string :category
      t.references :group

      t.timestamps
    end
  end
end
