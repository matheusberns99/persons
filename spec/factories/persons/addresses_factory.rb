FactoryBot.define do
  factory :address, class: ::Persons::Address do
    person_id { create(:person).id }

    street { Faker::Name.name }
    city { Faker::Name.name }
    state { Faker::Name.name }
    postal_code { 89053300 }
    country { Faker::Name.name }

    active { true }

    trait :deleted do
      active { false }
      deleted_at { Time.now }
    end
  end
end
