# frozen_string_literal: true

module Helper
  def login_user(user)
    sign_in user
  end

  def sign_up_user
    visit root_path
    click_button(I18n.t('home.signup'), match: :first)

    fill_in('Email', with: 'noname@noname.com')
    fill_in('Password', with: '1234piano')
    fill_in('Password confirmation', with: '1234piano')
    click_button('Sign up')
  end
end
