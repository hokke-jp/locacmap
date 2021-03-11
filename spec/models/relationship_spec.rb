require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let!(:alice) { create(:user) }
  let!(:bob) { create(:user) }
  let(:relationship) { Relationship.new(follower_id: alice.id, followed_id: bob.id) }

  it 'デフォルトでは誰もフォローしていない' do
    expect(alice.following.count).to eq 0
  end

  it 'follower_id、followed_id両方ある場合はOK' do
    expect(relationship).to be_valid
  end

  it 'follower_idがない場合はNG' do
    relationship.follower_id = nil
    expect(relationship).not_to be_valid
  end

  it 'followed_idがない場合はNG' do
    relationship.followed_id = nil
    expect(relationship).not_to be_valid
  end

  context 'aliceがbobをフォローした場合' do
    before do
      alice.follow(bob)
    end

    it 'aliceのフォローにbobが含まれる' do
      expect(alice.following?(bob)).to be true
    end

    it 'bobのフォロワーにaliceが含まれる' do
      expect(bob.followers.include?(alice)).to be true
    end

    it 'bobのフォローを外すと、aliceのフォローに含まれなくなる' do
      alice.unfollow(bob)
      expect(alice.following?(bob)).to be false
    end
  end
end
