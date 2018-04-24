class RechargeSubsConfig < ActiveRecord::Base
  self.table_name = "recharge_subs_config"
  # CREATE OBJECT TO TEST AGAINST RECHARGE RESPONSE
  attr_accessor :shopify_product_id, :shopify_variant_id, :sku, :product_title, :collection_property
  def setup(prod_id, variant_id, sku, prod_title, collection_prop)
    @shopify_product_id = prod_id
    @shopify_variant_id = variant_id
    @sku = sku
    @product_title = prod_title
    @collection_property = collection_prop
  end
end
