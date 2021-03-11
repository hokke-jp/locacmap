require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let!(:user) { create(:user) }
  let!(:period) { create(:period) }
  let!(:prefecture) { create(:prefecture) }
  let!(:micropost) do
    create(:micropost, user_id: user.id,
                       period_id: period.id,
                       prefecture_id: prefecture.id)
  end

  it '有効な入力ならOK' do
    expect(micropost).to be_valid
  end

  it 'タイトルが空ならNG' do
    micropost.title = ' '
    expect(micropost).not_to be_valid
  end

  it 'タイトルが40文字以下ならOK' do
    micropost.title = 'a' * 40
    expect(micropost).to be_valid
  end

  it 'タイトルが41文字以上ならNG' do
    micropost.title = 'a' * 41
    expect(micropost).not_to be_valid
  end

  it '説明文が空ならNG' do
    micropost.content = ' '
    expect(micropost).not_to be_valid
  end

  it '説明文が1000文字以下ならOK' do
    micropost.content = 'a' * 1000
    expect(micropost).to be_valid
  end

  it '説明文が1001文字以上ならNG' do
    micropost.content = 'a' * 1001
    expect(micropost).not_to be_valid
  end

  it '座標を入力していなかったらNG' do
    micropost.latlng = nil
    expect(micropost).not_to be_valid
  end

  it 'ユーザーidが空ならNG' do
    micropost.user_id = nil
    expect(micropost).not_to be_valid
  end

  it '時代を選択していなかったらNG' do
    micropost.period_id = nil
    expect(micropost).not_to be_valid
  end

  it '都道府県を選択していなかったらNG' do
    micropost.prefecture_id = nil
    expect(micropost).not_to be_valid
  end

  it '添付ファイルが5MB以下ならOK' do
    micropost.image.attach(io: File.open(Rails.root.join('spec/factories/images/less_than_5MB.jpg')), filename: 'less.jpg')
    expect(micropost.save).to be true
  end

  it '添付ファイルが5MB以上ならNG' do
    micropost.image.attach(io: File.open(Rails.root.join('spec/factories/images/larger_than_5MB.jpg')), filename: 'large.jpg')
    expect(micropost.save).to be false
  end

  it 'ユーザーを削除するとマイクロポストも削除される' do
    expect { user.destroy }.to change { Micropost.count }.by(-1)
  end
end
