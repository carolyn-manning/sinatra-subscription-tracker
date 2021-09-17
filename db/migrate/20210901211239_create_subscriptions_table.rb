class CreateSubscriptionsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.text :name
      t.decimal :price
      t.text :billing_frequency
      t.date :renewal_date
      t.integer :user_id
      t.timestamps null: false
  end
  end
end
