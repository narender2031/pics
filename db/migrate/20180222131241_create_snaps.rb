class CreateSnaps < ActiveRecord::Migration[5.1]
  def change
    create_table :snaps do |t|
      t.string :image
      t.integer :user_id

      t.timestamps
    end
  end
end
