FactoryBot.define do
  factory :person, class: ::Person do
    name { Faker::Name.name }
    email { "email@valido.com" }
    phone { "47992853825" }
    birthdate { Date.today - 25.years }

    active { true }

    trait :deleted do
      active { false }
      deleted_at { Time.now }
    end
  end
end
