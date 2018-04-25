class RechargeSubsConfig < ActiveRecord::Base
  self.table_name = "recharge_subs_config"
  # CREATE OBJECT TO TEST AGAINST RECHARGE RESPONSE
  def setup(product_id, variant_id, sku, product_title, collection_property)
    my_hash = {
      product_id: product_id,
      variant_id: variant_id,
      sku: sku,
      product_title: product_title,
      collection_property: collection_property
    }
    return my_hash
  end
end
