# frozen_string_literal: true

describe 'The signout process', type: :feature do
  let(:user) { create(:user) }

  it 'logout' do
    login_as(user, scope: :user)
    visit '/'
    within(:xpath, '//*[@id="navbarNav"]/ul[2]/li') do
      find(:xpath, '//*[@id="navbarNav"]/ul[2]/li/div/a', visible: false).click
    end
    expect(page).to have_current_path(root_path)
  end
end
