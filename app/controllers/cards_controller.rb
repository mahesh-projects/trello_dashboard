require 'json'

class CardsController < ApplicationController
  def index
  	@list_id = '570f165bd6b5fba021c69de4'
  	#@cards = Card.for @list_id

  	@cards = Card.to_csv @list_id
  end
end
