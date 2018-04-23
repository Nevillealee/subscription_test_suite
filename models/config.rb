class RechargeSubsConfig < ActiveRecord::Base
  self.table_name = "recharge_subs_config"

  attr_accessor :product_id, :variant_id, :sku, :product_title, :collection_property
  def initialize(prod_id, variant_id, sku, prod_title, collection_prop)
    @product_id = prod_id
    @variant_id = variant_id
    @sku = sku
    @product_title = prod_title
    @collection_property = collection_prop
  end
end
