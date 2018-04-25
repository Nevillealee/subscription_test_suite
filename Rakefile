require 'dotenv'
Dotenv.load
require 'active_record'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require_relative 'models/recharge_subs_config.rb'
Dir["./tests/*.rb"].each {|file| require file }
Dir["./scripts/*.rb"].each {|file| require file }
#
namespace :test do
  desc 'pass in subscription_id, tests subscription properties'
  task :subscription, :sub_id do |t, args|
    RechargeTest.start(args['sub_id'])
  end
end

namespace :subscription do
  desc 'pull recharge subs into db'
  task :pull do
    GetSubscriptions.pull_subs
  end
end

namespace :postgres do
  desc 'delete recharge subscriptions table'
  task :delete do
    Postgres.delete_table
  end
end

namespace :customer do
  desc 'pull customer from shopify'
  task :pull, :cust_id do |t, args|
    ShopifyCust.pull(args['cust_id'])
  end
end
