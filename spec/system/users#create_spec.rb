require 'rails_helper'

describe 'Users', type: :system do
  describe '#create' do
    let!(:user) { build(:user) }

    context "無効な入力では" do
      before do
        visit signup_path
        fill_in 'ユーザー名',	with: 'A' * 21
        # クライアント側検証が発生し登録ボタンが押せなくなるためmailは有効なものを使用
        fill_in 'メールアドレス',	with: user.email
        fill_in 'パスワード',	with: 'foo'
        fill_in 'パスワード（確認）',	with: 'foobar'
      end

      it 'ユーザー数は増えない' do
        expect { click_on '登録' }.not_to change(User, :count)
      end

      it '再読み込みすると、alertが消える' do
        click_on '登録'
        expect(page).to have_title('アカウント作成 | 歴史地図')
        expect(page).to have_content('3つの入力エラー')
        visit current_path
        expect(page).to have_title('アカウント作成 | 歴史地図')
        expect(page).not_to have_content('3つの入力エラー')
      end
    end

    context "有効な入力では" do
      before do
        ActionMailer::Base.deliveries.clear
        visit signup_path
        fill_in 'ユーザー名',	with: user.name
        fill_in 'メールアドレス',	with: user.email
        fill_in 'パスワード',	with: user.password
        fill_in 'パスワード（確認）',	with: user.password
      end

      it 'ユーザー数が増える' do
        expect { click_on '登録' }.to change { User.count }.by(1)
      end
  
      it '再読み込みすると、alertが消える' do
        click_on '登録'
        expect(page).to have_title('歴史地図')
        expect(page).to have_content('確認メールを送信しました')
        visit current_path
        expect(page).to have_title('歴史地図')
        expect(page).not_to have_content('確認メールを送信しました')
      end
  
      it "メールが送られる" do
        click_on '登録'
        expect(page).to have_content('確認メールを送信しました')
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end
    end
  end
end