# frozen_string_literal: true

class AddAttributesToArchive < ActiveRecord::Migration[5.2]

  def change
    add_column :archives, :purchaser_name, :string
    add_column :archives, :item_description, :string
    add_column :archives, :item_price, :float
    add_column :archives, :purchase_count, :integer
    add_column :archives, :merchant_address, :string
    add_column :archives, :merchant_name, :string
  end

end
