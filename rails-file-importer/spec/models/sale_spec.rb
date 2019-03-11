# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sale, type: :model do
  it 'has a valid factory' do
    user = create(:user)
    expect(build(:sale, user: user)).to be_valid
  end

  describe 'ActiveRecord associations' do
    it { should belong_to(:user) }
  end

  describe 'ActiveModel validations' do
    it { should validate_presence_of(:purchaser_name) }
    it { should validate_presence_of(:item_description) }
    it { should validate_presence_of(:item_price) }
    it { should validate_presence_of(:purchase_count) }
    it { should validate_presence_of(:merchant_address) }
    it { should validate_presence_of(:merchant_name) }
  end
end
