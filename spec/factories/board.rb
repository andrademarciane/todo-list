FactoryBot.define do
  factory :board do
    name { Faker::Movies::HarryPotter.character }

    trait :with_tasks do
      after(:create) do |board|
        create_list(:task, 3, board: board)
      end
    end
  end
end