module Persons::Addresses
  class IndexSerializer < ActiveModel::Serializer
    attributes :id,
               :street,
               :city,
               :state,
               :country,
               :postal_code,
               :active
  end
end
