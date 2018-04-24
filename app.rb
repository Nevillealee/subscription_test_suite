require 'dotenv'
Dotenv.load
require 'active_record'
require 'httparty'
require "sinatra/activerecord"
require_relative 'models/recharge_subs_config.rb'
require 'minitest/autorun'

module RechargeTest
  class User_sub
    def initialize
      Dotenv.load
      @recharge_access_token = ENV['RECHARGE_ACCESS_TOKEN']
      @my_header = {
          "X-Recharge-Access-Token" => @recharge_access_token
      }
    end

    def pull(sub_id)
      @response = HTTParty.get("https://api.rechargeapps.com/subscriptions/#{sub_id}", :headers => @my_header)
      if @response.code == 200
        return @response["subscription"]
      else
        return @response
      end
    end

    def has_collection?(sub_props)
      sub_props["properties"].each do |item|
        if item["name"] == "product_collection"
          return item["value"]
        end
      end
      return false
    end
  end

  class Mini < Minitest::Test
    def setup
      @myclass = User_sub.new
    end

    def test_request_subscription
      sub_properties = @myclass.pull(14364784)
      test_values =  RechargeSubsConfig.new
      test_values.setup("614505873440", "6348420677664", "764204142729", "Desert Sage - 5 Items", "Desert Sage - 5 Items")
      assert sub_properties["shopify_product_id"].to_s == test_values.shopify_product_id
      assert sub_properties["shopify_variant_id"].to_s == test_values.shopify_variant_id
      assert sub_properties["sku"] == test_values.sku
      assert sub_properties["product_title"] == test_values.product_title
      assert @myclass.has_collection?(sub_properties) == test_values.collection_property
    end
  end
end
