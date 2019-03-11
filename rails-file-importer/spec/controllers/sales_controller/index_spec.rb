# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SalesController, type: :controller do
  describe 'GET index' do
    let!(:user) { create(:user_with_sales, sale_count: 20) }

    before do
      sign_in user
    end

    it 'assigns @sales' do
      get :index
      expect(assigns(:sales)).to eq(user.sales.paginate(page: 1))
    end

    it 'assigns @sales page 2' do
      get :index, params: { page: 2 }
      expect(assigns(:sales)).to eq(user.sales.paginate(page: 2))
    end

    it 'assigns @sales indicators' do
      get :index
      expect(assigns(:items)).to eq(user.sales.sum(:purchase_count))
      expect(assigns(:purchasers)).to eq(user.sales.group(:purchaser_name).count)
      expect(assigns(:gross)).to eq(user.sales.sum('item_price*purchase_count'))
      expect(assigns(:count)).to eq(user.sales.count)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end
end
