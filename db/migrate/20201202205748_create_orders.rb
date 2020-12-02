class CreateOrders < ActiveRecord::Migration[5.2]

  def change
    create_table :orders do |t|
      t.integer :user_id
      t.datetime :order_time
      t.boolean :checked_out
    end 
  end

end
