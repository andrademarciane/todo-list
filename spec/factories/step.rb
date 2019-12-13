FactoryBot.define do
  factory :step do
    name { Faker::Movies::HarryPotter.location }
    task
  end
end