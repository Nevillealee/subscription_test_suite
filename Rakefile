require 'dotenv'
Dotenv.load
require 'active_record'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require_relative 'app.rb'
require_relative 'models/recharge_subs_config.rb'
#
namespace :test do
  desc 'pass in subscription_id, tests subscription properties'
  task :subscription, :sub_id do |t, args|
      id = args.sub_id
      RechargeTest::Mini.setup(id)
    end
  end
