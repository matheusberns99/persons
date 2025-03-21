module Persons::Addresses
  class ShowSerializer < ActiveModel::Serializer
    attributes :id,
               :street,
               :city,
               :state,
               :country,
               :postal_code,
               :active,
               :created_at,
               :updated_at

    def created_at
      object.created_at.in_time_zone.iso8601
    end

    def updated_at
      object.updated_at.in_time_zone.iso8601
    end
  end
end
