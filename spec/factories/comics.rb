FactoryBot.define do
  factory :comic do
    sequence(:marvel_id) { |n| n }
    title { "Sample Comic" }
    cover_url { "http://example.com/cover.jpg" }
    upvotes { 0 }
  end
end
