class CreateIcecreams < ActiveRecord::Migration[5.2]
  
  def change
    
    create_table :icecreams do |t|
      t.string :flavor 
      t.integer :price 
    end

  end
  
end
