require 'rails_helper'

describe Relationship do
  let!(:alice) { create(:user) }
  let!(:bob) { create(:user) }
  before do
    @relationship = Relationship.new(follower_id: alice.id, followed_id: bob.id)
  end

  it 'follower_id、followed_id両方ある場合はOK' do
    expect(@relationship).to be_valid
  end

  it 'follower_idがない場合はNG' do
    @relationship.follower_id = nil
    expect(@relationship).not_to be_valid
  end

  it 'followed_idがない場合はNG'do
    @relationship.followed_id = nil
    expect(@relationship).not_to be_valid
  end
end