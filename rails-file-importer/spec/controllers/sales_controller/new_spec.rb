# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SalesController, type: :controller do
  describe 'GET new' do
    let!(:user) { create(:user_with_sales, sale_count: 20) }

    before do
      sign_in user
    end

    it 'assigns @sale' do
      get :new
      expect(assigns(:sale)).to be_a_new(Sale)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end
end
