FactoryBot.define do
  factory :product do
    name { 'Product' }
    price { 12.99 }
    status { true }
    photo_url { 'https://google.com/img.jpg' }
  end
end
