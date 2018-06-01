require 'open-uri'
require 'nokogiri'
require_relative 'token'


class Check
  class << self
    def current_auction
      Check.refresh
      auction_item_data = Check.item_price.each_slice(8).to_a
      item_counter = 0
      all_current_items = []
      while item_counter < auction_item_data.length
        current_item_info = {
        item_name: Check.item_name(item_counter),
         current_bid: auction_item_data[item_counter][1],
         minimum_bid: auction_item_data[item_counter][2],
         time_left: auction_item_data[item_counter][3],
         number_of_bids: auction_item_data[item_counter][4],
         realm_market_value: auction_item_data[item_counter][5],
         global_market_value: auction_item_data[item_counter][6],
         realm_ah_current_quantity: auction_item_data[item_counter][7]
        }
        all_current_items << current_item_info
        item_counter += 1
      end
      all_current_items
    end

    def refresh
      @doc = Nokogiri::HTML(open("https://www.tradeskillmaster.com/black-market?realm=US-area-52"))
      ##### Test file
      # @doc = File.open('./spec/TSM_bmah_sample.xml') { |f| Nokogiri::XML(f) }
    end

    def updated_at
      @doc.xpath('//div//p').children.first.text
    end

    def item_price
      counter = 0
      item_price_collection = []
      until counter >= @doc.xpath('//table//tbody//td').length
        item_price_collection << @doc.xpath('//table//tbody//td')[counter].text
        counter += 1
      end
      item_price_collection
    end

    def item_name(entry)
      @doc.xpath('//table//tbody//td//a')[entry].attribute('title').text
    end
  end
end
