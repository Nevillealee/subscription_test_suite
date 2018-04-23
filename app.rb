require 'dotenv'
Dotenv.load
require 'active_record'
require 'httparty'
require "sinatra/activerecord"
require_relative 'models/config'

module TestRecharge
  class User_subs
    def initialize
    Dotenv.load
    @recharge_access_token = ENV['RECHARGE_ACCESS_TOKEN']
    @my_header = {
        "X-Recharge-Access-Token" => @recharge_access_token
    }
    @my_change_charge_header = {
        "X-Recharge-Access-Token" => @recharge_access_token,
        "Accept" => "application/json",
        "Content-Type" =>"application/json"
    }
    end
  end

end
