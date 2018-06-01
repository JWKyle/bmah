get '/area-52' do
  @auctions = Check.current_auction
  erb :'index'
end
