FactoryBot.define do
  factory :user, class: ::User do
    password = 'Senha@123'

    email { Faker::Internet.email }
    password { password }
    password_confirmation { password }

    trait :deleted do
      active { false }
      deleted_at { Time.now }
    end
  end
end
