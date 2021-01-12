require 'rails_helper'

describe "Pages", type: :system do
  context "ログインしていない時の" do
    it "ヘッダーのリンクの検証" do
      visit root_path
      expect(page).to have_link 'applogo'
      expect(page).to have_link '簡単ログイン'
      expect(page).to have_link 'ログイン'
      expect(page).to have_link '新規登録'
    end
  end

  context "ログインしている時の" do
    let!(:user) { create(:user) }
    it "ヘッダーのリンクの検証" do
      log_in_as(user)
      visit root_path
      expect(page).to have_link 'applogo'
      expect(page).to have_link 'post'
      expect(page).to have_link user.name
    end
  end
end

