require 'json'
require 'httparty'
require 'date'

class Card < ActiveRecord::Base
	include HTTParty

	key_value = ENV["TRELLO_API_KEY"]
	token_value	= ENV["TRELLO_API_SECRET"]
	base_uri  "https://api.trello.com/1/lists"
	
	#base_uri "https://api.trello.com/1/boards/570f15504dce0625826fbae7"
	default_params key: key_value, token: token_value 
	format :json

	def self.for list_id
		
		get("/#{list_id}/cards")
	end

	def self.to_csv list_id

		@cards = call_trello(list_id)
		
		@cards
	end

	private

	def self.call_trello list_id

		#create an empty array. this will be used to store the hashes cards
		#each hash would contain name, days, category E.g.: {name: "make popcorn [2]", days: 2, labels: ["Popcorn", "Fun"]}
		@cards = []
		

		if Card.count == 0 || Date.today > Card.first["updated_at"]

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

				#Initialize an empty array to store the labels
				#Loop through the labels and push them into the array
				labels = []

				result["labels"].each do |label|
					labels << label["name"]
				end

				#Push the hash into @cards array
				@cards << {"name" => name, "days" => days, "labels" => labels}
				

				#Save the card into the Cards table
				#Convert the labels array to comma separated string
				
				
				store_to_db({"name" => name, "days" => days, "labels" => labels.to_csv})

			end
			#puts "call api"
			
			
		else

			puts "retrieve from table"
			Card.all.each do |card|
				@cards << {"name" => card["card_name"], "days" => card["number_of_days"], "labels" => card["labels"].parse_csv}
			end
			
		end
		
		@cards
		
	end


	def self.store_to_db card	

		newCard = Card.new

		newCard.card_name = card["name"]
		newCard.number_of_days = card["days"]
		newCard.labels = card["labels"]

		newCard.created_at = Date.today.to_s
		newCard.updated_at = Date.today.to_s

		newCard.save

	end
end
