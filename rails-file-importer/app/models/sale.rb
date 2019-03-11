# frozen_string_literal: true

class Sale < ApplicationRecord

  belongs_to :user

  validates :purchaser_name, :item_description, :item_price, :purchase_count,
            :merchant_address, :merchant_name, presence: true

end
