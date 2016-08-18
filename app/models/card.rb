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
end
