class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.references :school, index: true, foreign_key: true
      t.text :description
      t.text :content
      t.string :duration
      t.float :price

      t.timestamps null: false
    end
  end
end
