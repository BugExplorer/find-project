FactoryGirl.define do
  factory :post do
    title 'Test title'
    body 'Test body'
  end

  factory :invalid_post, class: 'Post' do
    title nil
    body 'Test invalid body'
  end
end
