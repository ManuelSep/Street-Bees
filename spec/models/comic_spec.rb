require 'rails_helper'

RSpec.describe Comic, type: :model do
  it 'is valid with valid attributes' do
    comic = Comic.new(title: 'Sample Title', cover_url: 'http://example.com/cover.jpg', marvel_id: 12345)
    expect(comic).to be_valid
  end

  it 'is not valid without a title' do
    comic = Comic.new(title: nil, cover_url: 'http://example.com/cover.jpg', marvel_id: 12345)
    expect(comic).to_not be_valid
  end

  it 'is not valid without a cover_url' do
    comic = Comic.new(title: 'Sample Title', cover_url: nil, marvel_id: 12345)
    expect(comic).to_not be_valid
  end

  it 'is not valid without a marvel_id' do
    comic = Comic.new(title: 'Sample Title', cover_url: 'http://example.com/cover.jpg', marvel_id: nil)
    expect(comic).to_not be_valid
  end

  it 'is not valid with a duplicate marvel_id' do
    Comic.create(title: 'Sample Title', cover_url: 'http://example.com/cover.jpg', marvel_id: 12345)
    comic = Comic.new(title: 'Another Title', cover_url: 'http://example.com/another_cover.jpg', marvel_id: 12345)
    expect(comic).to_not be_valid
  end
end
