require 'rails_helper'

describe Micropost do
  let!(:user) { create(:user) }
  before do
    @micropost = user.microposts.build(content: 'Hello world!')
  end

  it '有効な入力だとOK' do
    expect(@micropost).to be_valid
  end

  it 'ユーザーidが空だとNG' do
    @micropost.user_id = nil
    expect(@micropost).not_to be_valid
  end

  it 'コンテンツが空だとNG' do
    @micropost.content = ' '
    expect(@micropost).not_to be_valid
  end

  it 'コンテンツが141文字以上だとNG' do
    @micropost.content = 'a' * 141
    expect(@micropost).not_to be_valid
  end

  it 'コンテンツが140文字以下だとOK' do
    @micropost.content = 'a' * 140
    expect(@micropost).to be_valid
  end

  it '最も新しいマイクロポストを最初に表示する' do
    alice = create(:user)
    bob = create(:user)
    alice.microposts.create(content: 'I am Alice.')
    bob_post = bob.microposts.create(content: 'I am Bob.')
    expect(Micropost.first).to eq bob_post
  end

  it 'ユーザーを削除するとマイクロポストも削除される' do
    alice = create(:user)
    alice.microposts.create!(content: 'I am Alice.')
    expect { alice.destroy }.to change { Micropost.count }.by(-1)
  end
end
