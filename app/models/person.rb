class Person < ApplicationRecord
  self.table_name = "persons"

  # Concerns
  include Filterable

  # Has_many associations
  has_many :addresses, class_name: "::Persons::Address", inverse_of: :person, foreign_key: :person_id

  # Scopes
  scope :by_active, lambda { |active|
    active_boolean = ActiveModel::Type::Boolean.new.cast(active)

    where(active: active_boolean)
  }
  scope :by_name, lambda { |name|
    where("UNACCENT(#{table_name}.name) ILIKE :name", name: "%#{I18n.transliterate(name.strip)}%")
  }
  scope :by_email, lambda { |email|
    where("UNACCENT(#{table_name}.email) ILIKE :email", email: "%#{I18n.transliterate(email.strip)}%")
  }
  scope :by_phone, lambda { |phone|
    where("#{table_name}.phone ILIKE :phone", phone: "%#{I18n.transliterate(phone.strip)}%")
  }
  scope :by_birthdate, lambda { |start_date_string = nil, end_date_string = nil|
    start_date = Time.zone.parse(start_date_string).beginning_of_day if start_date_string.present?
    end_date = Time.zone.parse(end_date_string).end_of_day if end_date_string.present?

    if start_date && end_date
      where("#{table_name}.birthdate BETWEEN :start_date AND :end_date", start_date: start_date, end_date: end_date)
    elsif start_date
      where("#{table_name}.birthdate >= :start_date", start_date: start_date)
    elsif end_date
      where("#{table_name}.birthdate <= :end_date", end_date: end_date)
    end
  }

  # Validations
  validates :name,
            :email,
            :phone,
            :birthdate, presence: true, length: { maximum: 255 }

  validates :email, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    message: I18n.t("activerecord.errors.models.person.attributes.base.invalid_email_format"),
    on: %i[create update] }

  validate :birthdate_cannot_be_in_the_future, on: %i[create update]

  private

  def birthdate_cannot_be_in_the_future
    return if birthdate.blank? || birthdate <= Date.today

    errors.add(:base, :invalid_future_date)
  end
end
