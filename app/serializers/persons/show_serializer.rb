module Persons
  class ShowSerializer < ActiveModel::Serializer
    attributes :id,
               :name,
               :email,
               :phone,
               :birthdate,
               :active,
               :created_at,
               :updated_at
  end
end