FactoryBot.define do
  factory :message do
    user_one { create(:user) }
    user_two { create(:user) }
    team
  end
end