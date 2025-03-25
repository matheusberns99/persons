module Persons
  class IndexSerializer < ActiveModel::Serializer
    attributes :id,
               :name,
               :email,
               :phone,
               :birthdate,
               :active
  end
end
