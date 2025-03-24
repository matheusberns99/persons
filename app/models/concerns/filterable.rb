# frozen_string_literal: true

module Filterable
  extend ActiveSupport::Concern

  class_methods do
    def apply_filter(params)
      params.to_h.inject(all) do |objects, (filter, value)|
        objects.respond_to?("by_#{filter}") ? objects.send("by_#{filter}", value) : objects
      end
    end
  end
end
