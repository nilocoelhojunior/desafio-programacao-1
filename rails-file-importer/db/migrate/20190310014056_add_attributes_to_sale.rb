# frozen_string_literal: true

class AddAttributesToSale < ActiveRecord::Migration[5.2]

  def change
    add_column :sales, :purchaser_name, :string
    add_column :sales, :item_description, :string
    add_column :sales, :item_price, :float
    add_column :sales, :purchase_count, :integer
    add_column :sales, :merchant_address, :string
    add_column :sales, :merchant_name, :string
  end

end
