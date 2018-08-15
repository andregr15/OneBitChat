FactoryBot.define do
  factory :invite do
    team
    email { FFaker::Internet.email }
  end
end