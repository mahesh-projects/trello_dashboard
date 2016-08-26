class AddFeatureAndUrlToCards < ActiveRecord::Migration
  def change
  	add_column :cards, :card_type, :string
  	add_column :cards, :short_url, :string
  end
end
