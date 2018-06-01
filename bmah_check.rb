require_relative 'check'
require 'sinatra'

get '/' do
  Check.current_auction
end
