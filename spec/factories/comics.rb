FactoryBot.define do
  factory :comic do
    comic_id { 1 }
    title { 'My comic' }
    description { 'Some description' }
    comic_url { 'https://teste.com/comic' }
    thumbnail { 'https://teste.com/images/comic.jpg' }
  end
end
