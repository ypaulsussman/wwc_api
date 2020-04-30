class CreateTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :topics do |t|
      t.text :name

      t.timestamps
    end
  end
end
