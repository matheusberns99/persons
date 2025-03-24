class Persons::Address < ApplicationRecord
  self.table_name = "person_addresses"

  # Concerns
  include Filterable

  # Belongs_to associations
  belongs_to :person, class_name: "::Person", inverse_of: :addresses, foreign_key: :person_id

  # Scopes
  scope :by_active, lambda { |active|
    active_boolean = ActiveModel::Type::Boolean.new.cast(active)

    where(active: active_boolean)
  }
  scope :by_street, lambda { |street|
    where("UNACCENT(#{table_name}.street) ILIKE :street", street: "%#{I18n.transliterate(street.strip)}%")
  }
  scope :by_city, lambda { |city|
    where("UNACCENT(#{table_name}.city) ILIKE :city", city: "%#{I18n.transliterate(city.strip)}%")
  }
  scope :by_state, lambda { |state|
    where("UNACCENT(#{table_name}.state) ILIKE :state", state: "%#{I18n.transliterate(state.strip)}%")
  }
  scope :by_postal_code, lambda { |postal_code|
    where(postal_code: postal_code)
  }
  scope :by_country, lambda { |country|
    where("UNACCENT(#{table_name}.country) ILIKE :country", country: "%#{I18n.transliterate(country.strip)}%")
  }

  # Validations
  validates :street,
            :city,
            :state,
            :country, presence: true, length: { maximum: 255 }
  validates :postal_code, presence: true

  def self.apply_filter(params)
    persons = all

    persons = persons.by_active(params[:active]) if params[:active]
    persons = persons.by_street(params[:street]) if params[:street]
    persons = persons.by_city(params[:city]) if params[:city]
    persons = persons.by_state(params[:state]) if params[:state]
    persons = persons.by_postal_code(params[:postal_code]) if params[:postal_code]
    persons = persons.by_country(params[:country]) if params[:country]

    persons
  end
end
