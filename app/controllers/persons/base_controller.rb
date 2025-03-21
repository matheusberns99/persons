module Persons
  class BaseController < ::ApplicationController
    before_action :set_person

    private

    def set_person
      @person = ::Person.where(active: true).find(params[:person_id])
    end
  end
end
