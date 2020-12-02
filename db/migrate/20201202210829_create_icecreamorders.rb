class CreateIcecreamorders < ActiveRecord::Migration[5.2]
  
  def change
    
    create_table :icecreamorders do |t|
      t.integer :icecream_id
      t.integer :order_id
    end
 
  end
  
end
