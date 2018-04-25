require 'dotenv'
Dotenv.load
require 'active_record'
require 'httparty'
require "sinatra/activerecord"
require_relative '../models/customer.rb'
require 'minitest'
require 'shopify_api'

module ShopifyCust
  ShopifyAPI::Base.site =
    "https://#{ENV['SHOPIFY_API_KEY']}:#{ENV['SHOPIFY_SHARED_SECRET']}@#{ENV['SHOPIFY_SHOP_NAME']}.myshopify.com/admin"
    def self.pull(cust_id)
      cust = ShopifyAPI::Customer.find(cust_id)
      puts cust.to_json
    end
end
