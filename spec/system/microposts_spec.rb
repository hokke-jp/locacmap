require 'rails_helper'

describe MicropostsController, type: :system do
  let!(:period) { create(:period) }
  let!(:prefecture) { create(:prefecture) }

  describe '#index' do
    before do
      (1..11).each do |i|
        micropost = create(:micropost, period_id: period.id, prefecture_id: prefecture.id)
        eval("@micropost_#{i} = micropost")
      end
    end

    it '検索ページの項目チェック' do
      visit microposts_path
      expect(page).to have_title('検索 | 歴史地図')
      expect(page).to have_button 'Search'
      expect(find('#latest', visible: false)[:checked]).to eq 'true'
      expect(page).to have_selector 'nav.pagination'
    end

    it 'ページネーションの動作チェック' do
      visit microposts_path
      click_on '2'
      expect(page).to have_content @micropost_1.title
    end
  end

  describe '#new,#create' do
    let!(:micropost) { create(:micropost, period_id: period.id, prefecture_id: prefecture.id) }
    it '非ログイン時、投稿ページに遷移できない' do
      visit new_micropost_path
      expect(page).to have_title('ログイン | 歴史地図')
      expect(page).to have_content('ログインしてください')
    end

    context 'ログイン時' do
      before do
        log_in_as(micropost.user)
        visit new_micropost_path
      end

      it '投稿ページの項目チェック' do
        expect(page).to have_title('投稿作成 | 歴史地図')
        expect(page).to have_button('投稿')
      end

      it '無効な入力のならアラートが出る' do
        click_on '投稿'
        expect(page).to have_content '5つの入力エラー'
        expect(page).to have_content '・ピンを立ててください'
        expect(page).to have_content '・都道府県を選択してください'
        expect(page).to have_content '・時代を選択してください'
        expect(page).to have_content '・タイトルを入力してください'
        expect(page).to have_content '・説明文を入力してください'
      end

      it 'ファイルサイズが5MB以上ならアラートが出る' do
        page.dismiss_confirm('5MB以下のファイルを選択してください。') do
          attach_file 'micropost_image', Rails.root.join('spec/factories/images/larger_than_5MB.jpg')
        end
      end

      it 'ファイルサイズが5MB以下ならアラートが出ない' do
        attach_file 'micropost_image', Rails.root.join('spec/factories/images/less_than_5MB.jpg')
        expect(page).not_to have_content '5MB以下のファイルを選択してください。'
      end
    end
  end
end
