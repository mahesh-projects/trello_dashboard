require 'json'

class CardsController < ApplicationController
  def index
  	@list_id = '570f165bd6b5fba021c69de4'
  	#@cards = Card.for @list_id

  	@cards = Card.get_cards @list_id 
  	respond_to do |format|
	  	format.html # show.html.erb
	  	format.json { render json: @cards }
	 end
  end
end
