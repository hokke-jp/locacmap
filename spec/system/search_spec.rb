require 'rails_helper'

describe SearchesController, type: :system do
  describe '#sort' do
    let!(:period_before) { create(:period) }
    let!(:period) { create(:period) }
    let!(:period_after) { create(:period) }
    let!(:prefecture) { create(:prefecture) }
    let!(:user) { create(:user) }
    let!(:micropost_latest) { create(:micropost, period_id: period.id, prefecture_id: prefecture.id) }
    let!(:micropost_going) { create(:micropost, created_at: 1.hour.ago, period_id: period.id, prefecture_id: prefecture.id) }
    let!(:micropost_period_before) { create(:micropost, created_at: 1.hour.ago, period_id: period_before.id, prefecture_id: prefecture.id) }
    let!(:micropost_period_after) { create(:micropost, created_at: 1.hour.ago, period_id: period_after.id, prefecture_id: prefecture.id) }
    before do
      user.goings.create(micropost_id: micropost_going.id)
      visit microposts_path
    end

    it 'ページを訪れた時は最新順に表示されている' do
      expect(first('#mini-info').find('div.leading-5').text).to eq micropost_latest.title
    end

    it '行ってみたい順動作チェック' do
      click_link '行ってみたい!'
      sleep 1
      expect(first('#mini-info').find('div.leading-5').text).to eq micropost_going.title
    end

    it '時代昇順動作チェック' do
      click_link '時代昇順'
      sleep 1
      expect(first('#mini-info').find('div.leading-5').text).to eq micropost_period_before.title
    end

    it '時代降順動作チェック' do
      click_link '時代降順'
      sleep 1
      expect(first('#mini-info').find('div.leading-5').text).to eq micropost_period_after.title
    end
  end

  describe '#search' do
    let!(:period) { create(:period) }
    let!(:prefecture) { create(:prefecture) }
    let!(:micropost) { create(:micropost, period_id: period.id, prefecture_id: prefecture.id) }
    before do
      visit microposts_path
    end

    it '検索すると検索条件と地図リンクが表示される' do
      fill_in 'search',	with: '第1回'
      select period.name, from: 'period_id'
      select prefecture.name, from: 'prefecture_id'
      click_on 'Search'
      sleep 1
      expect(page).to have_content "\"第1回\" \"#{prefecture.name}\" \"#{period.name}\" の検索結果"
      expect(page).to have_link '検索結果を地図で見る'
    end

    it '検索条件に何もヒットしなかった場合は何も表示されない' do
      fill_in 'search',	with: 'aaaaa'
      click_on 'Search'
      expect(page).to have_content '該当する結果がありませんでした。'
    end

    it 'タイトルの部分一致検索動作チェック' do
      fill_in 'search',	with: 'タイトル'
      click_on 'Search'
      sleep 1
      expect(first('#mini-info').find('div.leading-5').text).to eq micropost.title
    end

    it '説明文の部分一致検索動作チェック' do
      fill_in 'search',	with: '説明文'
      click_on 'Search'
      sleep 1
      expect(first('#mini-info').find('div.leading-5').text).to eq micropost.title
    end

    it 'ユーザー名検索の動作チェック' do
      fill_in 'search',	with: micropost.user.name
      click_on 'Search'
      sleep 1
      expect(first('#mini-info').find('div.leading-5').text).to eq micropost.title
    end

    it '時代検索の動作チェック' do
      select period.name, from: 'period_id'
      click_on 'Search'
      sleep 1
      expect(first('#mini-info').find('div.leading-5').text).to eq micropost.title
    end

    it '都道府県検索の動作チェック' do
      select prefecture.name, from: 'prefecture_id'
      click_on 'Search'
      sleep 1
      expect(first('#mini-info').find('div.leading-5').text).to eq micropost.title
    end

    it '複数条件の動作チェック' do
      fill_in 'search',	with: "タイトル 説明文　#{micropost.user.name}"
      select period.name, from: 'period_id'
      select prefecture.name, from: 'prefecture_id'
      click_on 'Search'
      sleep 1
      expect(first('#mini-info').find('div.leading-5').text).to eq micropost.title
    end

    it '時代タグをクリックすると、その時代で検索が行われる' do
      click_on period.name
      expect(page).to have_content "\"#{period.name}\" の検索結果"
    end

    it '都道府県タグをクリックすると、その都道府県で検索が行われる' do
      click_on prefecture.name
      expect(page).to have_content "\"#{prefecture.name}\" の検索結果"
    end
  end
end
