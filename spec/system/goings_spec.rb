require 'rails_helper'

describe 'going', type: :system do
  let!(:period) { create(:period) }
  let!(:prefecture) { create(:prefecture) }
  let!(:user) { create(:user) }
  let!(:micropost) { create(:micropost, period_id: period.id, prefecture_id: prefecture.id) }
  let!(:checked_micropost) { create(:micropost, period_id: period.id, prefecture_id: prefecture.id) }
  before do
    Going.create(user_id: user.id, micropost_id: checked_micropost.id)
  end

  context '非ログインユーザーの場合' do
    before do
      visit microposts_path
    end

    it '行ってみたいボタンが表示される' do
      expect(page).to have_button('行ってみたい', count: 2)
    end

    it '記事に押された行ってみたいの数が表示される' do
      expect(all('span.going-count').map(&:text).map(&:to_i)).to include micropost.goings.count, checked_micropost.goings.count
    end

    it '行ってみたいボタンを押すとログインを要求される' do
      first('button.going').click
      expect(page).to have_title 'ログイン | 歴史地図'
      expect(page).to have_content 'ログインしてください'
    end
  end

  context 'ログインユーザーの場合' do
    before do
      log_in_as(user)
      visit microposts_path
    end

    it '記事をチェックしていなければ行ってみたいボタンが表示される' do
      expect(find("#micropost-#{micropost.id}")).to have_button '行ってみたい'
    end

    it '記事をチェックしていればチェックを外すボタンが表示される' do
      expect(find("#micropost-#{checked_micropost.id}")).to have_button 'チェックを外す'
    end

    context '行ってみたいボタンをクリックすると' do
      it 'micropostの行ってみたいが1増える' do
        expect { click_button '行ってみたい' }.to change {
          within "#micropost-#{micropost.id}" do
            find('span.going-count').text.to_i
          end
        }.by(1)
      end

      it 'チェックを外すボタンが表示される' do
        click_button '行ってみたい'
        expect(find("#micropost-#{micropost.id}")).to have_button 'チェックを外す'
      end
    end

    context 'チェックを外すボタンをクリックすると' do
      it 'micropostの行ってみたいが1減る' do
        expect { click_button 'チェックを外す' }.to change {
          within "#micropost-#{checked_micropost.id}" do
            find('span.going-count').text.to_i
          end
        }.by(-1)
      end

      it 'チェックを外すボタンが表示される' do
        click_button 'チェックを外す'
        expect(find("#micropost-#{checked_micropost.id}")).to have_button '行ってみたい'
      end
    end
  end
end
