module Users
  class IndexSerializer < ActiveModel::Serializer
    attributes :id,
               :email
  end
end
