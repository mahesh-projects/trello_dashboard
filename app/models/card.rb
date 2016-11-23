require 'json'
require 'httparty'
require 'date'

class Card < ActiveRecord::Base
	include HTTParty
	#Setup to call Trello
	key_value = ENV["TRELLO_API_KEY"]
	token_value	= ENV["TRELLO_API_SECRET"]
	base_uri  "https://api.trello.com/1/lists"
	
	default_params key: key_value, token: token_value 
	format :json

	#Method to get the cards - either from Trello OR from DB
	def self.get_cards list_id

		if Card.count == 0 || Date.today > Card.first["updated_at"]

			call_trello(list_id)

		else

			get_cards_from_db

		end		
	end

	private
	#Call Trello to get a refresh the records in Cards table
	def self.call_trello list_id
		#create an empty array. this will be used to store the hashes cards
		#each hash would contain name, days, category E.g.: {name: "make popcorn [2]", days: 2, labels: ["Popcorn", "Fun"]}
		@cards = []
		puts "call trello"
			
		Card.destroy_all
		#store the response in @results
		@results = get("/#{list_id}/cards")
		
		#loop through the results to extract card_name, days and category
		@results.each do |result|
			#Extract card name
			name = result["name"]

			#Extract the number of days from the end of the name string
			count = result["name"].scan(/\[(.*)\]/)[0]
			days = count[0].to_i unless count.nil?

			#Extract the shortUrl for each card 
			short_url = result["shortUrl"]

			#Extract the dateLastActivity as the ShippedDate for each card - IT IS A HACK... REMEMBER!!
			shipped_date = result["dateLastActivity"]

			#Initialize an empty array to store the labels
			#Loop through the labels and push them into the array
			labels = []

			result["labels"].each do |label|
				labels << label["name"]
			end

			#Use the first label to classify the card
			card_type = classify_card_type(labels[0])

			#Push the hash into @cards array
			@cards << {"name" => name, "days" => days, "labels" => labels[0], "url" => short_url, "card_type" => card_type, "shipped_date" => shipped_date}
			

			#Save the card into the Cards table
			#Convert the labels array to comma separated string
			store_to_db({"name" => name, "days" => days, "labels" => labels.to_csv, "url" => short_url, "card_type" => card_type, "shipped_date" => shipped_date})

		end
		@cards
	end

	#Get cards from DB
	def self.get_cards_from_db 
		#create an empty array. this will be used to store the hashes cards
		#each hash would contain name, days, category E.g.: {name: "make popcorn [2]", days: 2, labels: ["Popcorn", "Fun"]}
		@cards = []
		puts "retrieve from table"
		Card.all.each do |card|
			@cards << {"name" => card["card_name"], "days" => card["number_of_days"], "labels" => card["labels"].parse_csv[0], "url" => card["short_url"], "card_type" => card["card_type"]}
		end
		@cards

	end

	#Store cards into the DB Table
	def self.store_to_db card	

		newCard = Card.new

		newCard.card_name = card["name"]
		newCard.number_of_days = card["days"]
		newCard.labels = card["labels"]
		newCard.short_url = card["url"]
		newCard.card_type = card["card_type"]
		newCard.shipped_date = card["shipped_date"]

		newCard.created_at = Date.today.to_s
		newCard.updated_at = Date.today.to_s

		newCard.save

	end

	#Classify the cards as Feature, Custodianship etc before saving them to the table
	def self.classify_card_type first_label

		card_type = ''

		case first_label
		  when 'Consumer Segmentation', 'Content Based Rec', 'Rec Engine', 'Defect', 'Consumer Profile'
		    card_type = 'Feature'
		  when 'Custodianship', 'AWS'
		    card_type = 'Custodianship'
		  when 'Tech Debt'
		  	card_type = 'Tech Debt'
		  when 'production issue'
		  	card_type = 'Production Issue'
		  else 
		    card_type = 'Uncategorized'
		end 
		
		card_type
	end

end