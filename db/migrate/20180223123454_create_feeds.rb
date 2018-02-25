class CreateFeeds < ActiveRecord::Migration[5.1]
  def change
    create_table :feeds do |t|
      t.string :image
      t.integer :user_id
      t.datetime :time
      t.string :user_name
      t.string :name
      t.integer :subs_user_id

      t.timestamps
    end
  end
end
