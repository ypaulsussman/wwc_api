class CreateUrbanicities < ActiveRecord::Migration[6.0]
  def change
    create_table :urbanicities do |t|
      t.text :name

      t.timestamps
    end
  end
end
