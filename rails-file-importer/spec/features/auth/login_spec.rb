# frozen_string_literal: true

describe 'The signin process', type: :feature do
  let(:user) { create(:user) }

  it 'login' do
    visit '/'
    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: '123456'
    end
    click_button 'Entrar'
    expect(page).to have_current_path(sales_path)
  end
end
