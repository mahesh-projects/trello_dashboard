require 'json'
require 'httparty'

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
		Card.count

		if @cards.nil? 
			#store the response in @results
			@results = get("/#{list_id}/cards")
			#create an empty array. this will be used to store the hashes cards
			#each hash would contain name, days, category E.g.: {name: "make popcorn [2]", days: 2, labels: ["Popcorn", "Fun"]}
			@cards = []

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
			end
			puts "call api"
			@cards
		else
			puts "retrieve object"
			@cards
		end
	end
end
