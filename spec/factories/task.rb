FactoryBot.define do
  factory :task do
    title { Faker::Superhero.name }
  end
end
