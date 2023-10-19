class CreateTops < ActiveRecord::Migration[7.0]
  def change
    create_table :tops do |t|
      t.string :content

      t.timestamps
    end
  end
end
