# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  describe 'ActiveRecord associations' do
    it { should have_many(:sales).dependent(:destroy) }
  end
end
