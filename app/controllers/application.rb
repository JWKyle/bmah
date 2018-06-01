require_relative '../models/token'
require_relative '../models/check'
require 'sinatra'

get '/area-52' do
  @auctions = Check.current_auction
  @token_price = Token.current_price
  erb :"area-52/index.html"
end
