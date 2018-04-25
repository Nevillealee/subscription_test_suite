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
    RechargeTest.start(args['sub_id'])
    end
  end

namespace :postgres do
  desc 'pull recharge subs into db'
  task :pull do
    Postgres.pull_subs
  end

  desc 'delete recharge subscriptions table'
  task :delete do
    Postgres.delete_table
  end
end
