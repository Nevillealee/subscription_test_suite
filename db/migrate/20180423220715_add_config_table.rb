class AddConfigTable < ActiveRecord::Migration[5.1]
  def up
    create_table :recharge_subs_config do |t|
      t.string :shopify_product_id
      t.string :shopify_variant_id
      t.string :sku
      t.string :product_title
      t.string :collection_property
    end
  end

  def down
    drop_table :recharge_subs_config
  end
end
