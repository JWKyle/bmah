require_relative 'token'
require_relative 'check'

get '/area-52' do
  @auctions = Check.current_auction
  @token_price = Token.current_price
  erb :'area-52/index'
end
