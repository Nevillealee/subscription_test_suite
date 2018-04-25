require 'dotenv'
Dotenv.load
require 'active_record'
require 'httparty'
require "sinatra/activerecord"
require_relative 'models/recharge_subs_config.rb'
require 'minitest/autorun'

# module RechargeTest
#   def self.start(param)
#     $param = param
#     $test_values = RechargeSubsConfig.new.setup(
#       "614505873440",
#       "6348420677664",
#       "764204142729",
#       "Desert Sage - 5 Items",
#       "Desert Sage - 5 Items"
#     )
#   end
#
#   class Mini < Minitest::Test
#     def has_collection?(sub_props)
#       sub_props["properties"].each do |item|
#         if item["name"] == "product_collection"
#           return item["value"]
#         end
#       end
#       return false
#     end
#
#     def test_request_subscription
#       @recharge_access_token = ENV['RECHARGE_ACCESS_TOKEN']
#       @my_header = {
#         "X-Recharge-Access-Token" => @recharge_access_token
#       }
#       @response = HTTParty.get("https://api.rechargeapps.com/subscriptions/14364784", :headers => @my_header)
#       sub_properties = @response["subscription"]
#
#       assert sub_properties["shopify_product_id"].to_s == $test_values[:product_id]
#       assert sub_properties["shopify_variant_id"].to_s == $test_values[:variant_id]
#       assert sub_properties["sku"] == $test_values[:sku]
#       assert sub_properties["product_title"] == $test_values[:product_title]
#       assert self.has_collection?(sub_properties) == $test_values[:collection_property]
#     end
#   end
# end

module Postgres
  @recharge_access_token = ENV['RECHARGE_ACCESS_TOKEN']
  @my_header = {
    "X-Recharge-Access-Token" => @recharge_access_token
  }
  def self.has_collection?(sub_props)
    sub_props["properties"].each do |item|
      if item["name"] == "product_collection"
        return item["value"]
      end
    end
    return ""
  end

  def self.pull_subs
    num_subs = background_count_subscriptions(@my_header)
    page_size = 250
    num_pages = (num_subs/page_size.to_f).ceil
    1.upto(num_pages) do |page|
      mysubs = HTTParty.get("https://api.rechargeapps.com/subscriptions?limit=250&page=#{page}", :headers => @my_header)
      local_sub = mysubs['subscriptions']
      puts "pulling down page #{page}"
      local_sub.each do |sub|
        if !sub['properties'].nil? && sub['properties'] != []
          RechargeSubsConfig.create(
            product_id: sub["shopify_product_id"],
            variant_id: sub["shopify_variant_id"],
            sku: sub["sku"],
            product_title: sub["product_title"],
            collection_property: has_collection?(sub)
          )
        end
        puts "saved subscription #{sub["id"]}"
      end
    end
  end

  def self.delete_table
    ActiveRecord::Base.connection.execute("TRUNCATE recharge_subs_config;")
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE recharge_subs_config_id_seq RESTART;")
  end

  def self.background_count_subscriptions(header_info)
    subscriptions = HTTParty.get("https://api.rechargeapps.com/subscriptions/count", :headers => header_info)
    my_response = JSON.parse(subscriptions)
    my_count = my_response['count'].to_i
    return my_count
  end
end
