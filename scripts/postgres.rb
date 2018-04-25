module Postgres
  def self.delete_table
    ActiveRecord::Base.connection.execute("TRUNCATE recharge_subs_config;")
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE recharge_subs_config_id_seq RESTART;")
    puts "table successfully deleted"
  end
end
