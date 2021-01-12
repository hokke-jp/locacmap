require 'rails_helper'

describe "User", type: :system do

  describe "新規登録" do
    it "有効な入力をするとメールが送られる" do
      visit signup_path
      fill_in "ユーザー名",	with: "Alice" 
      fill_in "メールアドレス",	with: "alice@example.com"
      fill_in "パスワード",	with: "foobar"
      fill_in "パスワード（確認）",	with: "foobar"
      expect{ click_on '登録' }.to change{ User.count }.by(1)
      expect(page).to have_content('確認メールを送信しました')
      fill_in "テキスト",	with: "sometext" 
    end

    it "無効な入力をすると警告が出る" do
      visit signup_path
      fill_in "ユーザー名",	with: "A"*21
      #クライアント側検証が発生し登録ボタンを押せなくなるためmailは有効にする
      fill_in "メールアドレス",	with: "alice@example.com"
      fill_in "パスワード",	with: "foo"
      fill_in "パスワード（確認）",	with: "foobar"
      expect{ click_on '登録' }.not_to change{ User.count }
      expect(page).to have_content('3つの入力エラー')
    end
  end
  
  describe "登録変更" do
    let!(:alice) { create(:user) }
    it "有効な入力をすると更新できる" do
      visit root_path
      fill_in "テキスト",	with: User.last.id
      expect(subject).to 0
    end
  end
  
end