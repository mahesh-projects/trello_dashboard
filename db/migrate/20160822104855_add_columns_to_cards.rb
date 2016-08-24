class AddColumnsToCards < ActiveRecord::Migration
  def change
  	add_column :cards, :card_name, :string
  	add_column :cards, :number_of_days, :decimal
  	add_column :cards, :labels, :string
  end
end
