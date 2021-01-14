require 'rails_helper'

describe 'AccountActivations', type: :system do
  let!(:user) { build(:user) }
  before do
    ActionMailer::Base.deliveries.clear
  end

  it "有効化してない状態では,ログインできない" do
    visit signup_path
    fill_in 'ユーザー名',	with: user.name
    fill_in 'メールアドレス',	with: user.email
    fill_in 'パスワード',	with: user.password
    fill_in 'パスワード（確認）',	with: user.password
    click_on '登録'
    visit login_path
    fill_in 'メールアドレス',	with: user.email
    fill_in 'パスワード',	with: user.password
    click_button 'ログイン'
    expect(page).to have_content("アカウントの確認が取れませんでした。\nご登録のメールアドレスを確認してください。")
    expect(page).to have_title('歴史地図')
  end
end