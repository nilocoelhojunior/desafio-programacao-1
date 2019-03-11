# frozen_string_literal: true

require 'rails_helper'
include ActionDispatch::TestProcess::FixtureFile

RSpec.describe SalesController, type: :controller do
  describe 'POST create' do
    let!(:user) { create(:user) }
    let!(:file) { fixture_file_upload('example_input.tab') }

    before do
      sign_in user
    end

    it 'assigns created 4 sales' do
      post :create, params: { sale: { file: file } }
      expect(user.sales.count).to eq(4)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end
end
