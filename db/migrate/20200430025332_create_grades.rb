class CreateGrades < ActiveRecord::Migration[6.0]
  def change
    create_table :grades do |t|
      t.text :name

      t.timestamps
    end
  end
end
