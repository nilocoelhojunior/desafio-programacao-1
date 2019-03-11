# frozen_string_literal: true

describe 'The import file process', type: :feature do
  let(:user) { create(:user) }

  it 'visit import' do
    login_as(user, scope: :user)
    visit '/'
    within('.fa-table') do
      find(:xpath, '/html/body/div/div/div[1]/div/a').click
    end
    expect(page).to have_current_path(new_sale_path)
  end

  it 'import file' do
    login_as(user, scope: :user)
    visit new_sale_path
    within('.fa-table') do
      input = find(:xpath, '//*[@id="customFile"]', visible: false)
      input.attach_file(Rails.root + 'spec/fixtures/example_input.tab')
    end
    click_button('Importar')
    expect(page).to have_current_path(sales_path)
  end
end
