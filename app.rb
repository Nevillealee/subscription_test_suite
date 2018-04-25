require 'dotenv'
Dotenv.load
require 'active_record'
require 'httparty'
require "sinatra/activerecord"
require_relative 'models/recharge_subs_config.rb'
require 'minitest/autorun'

module RechargeTest
  def self.start(param)
    $param = param
    $test_values = RechargeSubsConfig.new.setup("614505873440", "6348420677664", "764204142729", "Desert Sage - 5 Items", "Desert Sage - 5 Items")
  end

  class Mini < Minitest::Test
    def has_collection?(sub_props)
      sub_props["properties"].each do |item|
        if item["name"] == "product_collection"
          return item["value"]
        end
      end
      return false
    end

    def test_request_subscription
      Dotenv.load
      @recharge_access_token = ENV['RECHARGE_ACCESS_TOKEN']
      @my_header = {
          "X-Recharge-Access-Token" => @recharge_access_token
      }
      @response = HTTParty.get("https://api.rechargeapps.com/subscriptions/14364784", :headers => @my_header)
      sub_properties = @response["subscription"]
      assert sub_properties["shopify_product_id"].to_s == $test_values[:product_id]
      assert sub_properties["shopify_variant_id"].to_s == $test_values[:variant_id]
      assert sub_properties["sku"] == $test_values[:sku]
      assert sub_properties["product_title"] == $test_values[:product_title]
      assert self.has_collection?(sub_properties) == $test_values[:collection_property]
    end
  end
end
