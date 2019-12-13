FactoryBot.define do
  factory :task do
    name { Faker::Movies::HarryPotter.character }
    description { Faker::Movies::HarryPotter.quote }
    board

    trait :with_steps do
      after(:create) do |task|
        create_list(:step, 3, task: task)
      end
    end
  end
end