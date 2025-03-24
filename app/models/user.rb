class User < ApplicationRecord
  self.table_name = "users"

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  scope :by_email, lambda { |email|
    where("#{table_name}.email ILIKE :email", email: "%#{I18n.transliterate(email.strip)}%")
  }

  def self.apply_filter(params)
    users = all

    users = users.by_name(params[:name]) if params[:name]

    users
  end
end
