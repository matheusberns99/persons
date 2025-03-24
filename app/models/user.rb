class User < ApplicationRecord
  self.table_name = "users"

  # Concerns
  include Filterable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  scope :by_email, lambda { |email|
    where("UNACCENT(#{table_name}.email ILIKE :email)", email: "%#{I18n.transliterate(email.strip)}%")
  }
end
