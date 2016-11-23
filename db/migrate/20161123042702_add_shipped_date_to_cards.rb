class AddShippedDateToCards < ActiveRecord::Migration
  def change
    add_column :cards, :shipped_date, :date
  end
end
