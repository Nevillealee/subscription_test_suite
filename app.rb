require 'dotenv'
Dotenv.load
require 'active_record'
require 'httparty'
require "sinatra/activerecord"
require_relative 'models/recharge_subs_config'
require 'minitest/autorun'

module RechargeTest
  class User_subs
    def initialize
    Dotenv.load
    @recharge_access_token = ENV['RECHARGE_ACCESS_TOKEN']
    @my_header = {
        "X-Recharge-Access-Token" => @recharge_access_token
    }
    end
    # pass in hash with subscription id (have another rake task gen list of ids?)
    def pull(params)
      @response = HTTParty.get("https://api.rechargeapps.com/subscriptions/#{params['subscription_id']}", :headers => @my_header)
      if @response.code == 200
        return @response.body
      else
        # LOG ERROR TO OUTPUT
        return @response
      end
    end
  end

  class Mini < Minitest::Test
    def test_request_subscription
      user_sub = User_subs.new
      params = {subscription_id: '507621212192'}
      sub_properties = user_sub.pull(params)
      assert sub_properties == 
    end
  end

end


#  EXAMPLE RESPONSE
# {
#     "subscription": {
#         "id": 13771142,
#         "address_id": 9364792,
#         "customer_id": 9476622,
#         "created_at": "2018-03-27T14:26:12",
#         "updated_at": "2018-03-27 14:26:12",
#         "next_charge_scheduled_at": "2017-04-01T00:00:00",
#         "cancelled_at": null,
#         "product_title": "Sumatra Coffee",
#         "variant_title": "Milk - a / b",
#         "price": 12,
#         "quantity": 1,
#         "status": "ACTIVE",
#         "shopify_product_id": 1255183683,
#         "shopify_variant_id": 3844924611,
#         "sku": null,
#         "order_interval_unit": "day",
#         "order_interval_frequency": "30",
#         "charge_interval_frequency": "30",
#         "cancellation_reason": null,
#         "cancellation_reason_comments": null,
#         "order_day_of_week": null,
#         "order_day_of_month": null,
#         "properties": [
#             {
#                 "name": "grind",
#                 "value": "drip"
#             },
#             {
#                 "name": "size",
#                 "value": "medium"
#             }
#         ],
#         "expire_after_specific_number_of_charges": 2
#     }
# }
