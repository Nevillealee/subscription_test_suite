require 'dotenv'
Dotenv.load
require 'active_record'
require 'httparty'
require "sinatra/activerecord"

module GetSubscriptions
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

private
  def self.background_count_subscriptions(header_info)
    subscriptions = HTTParty.get("https://api.rechargeapps.com/subscriptions/count", :headers => header_info)
    my_response = JSON.parse(subscriptions)
    my_count = my_response['count'].to_i
    return my_count
  end
end
