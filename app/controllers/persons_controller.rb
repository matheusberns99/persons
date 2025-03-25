# frozen_string_literal: true

class PersonsController < ApplicationController
  before_action :set_person, only: %i[show update destroy recover]
  before_action :authenticate_user!

  def index
    persons = Person.apply_filter(filter_params)

    render_json(persons, Persons::IndexSerializer, "persons", :ok)
  end

  def show
    render_json(@person, Persons::ShowSerializer, "person", :ok)
  end

  def create
    person = Person.new(person_params)

    if person.save
      render_json(person, Persons::ShowSerializer, "person", :created)
    else
      render json: { errors: person.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @person.update(person_params)
      render_json(@person, Persons::ShowSerializer, "person", :ok)
    else
      render json: { errors: @person.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @person
      @person.update(active: false, deleted_at: Time.current)

      render json: {}, status: :ok
    else
      render json: { errors: I18n.t("errors.messages.register_not_found") }, status: :not_found
    end
  end

  def recover
    person = Person.where(active: false).find_by(id: params[:id])

    if person
      person.update(active: true, deleted_at: nil)

      render_json(person, Persons::ShowSerializer, "person", :ok)
    else
      render json: { errors: I18n.t("errors.messages.register_not_found") }, status: :not_found
    end
  end

  private

  def set_person
    @person = Person.find_by(id: params[:id])

    return if @person

    record_not_found
  end

  def person_params
    params
      .require(:person)
      .permit(:name,
              :email,
              :phone,
              :birthdate)
  end

  def filter_params
    params
      .permit(:name,
              :active,
              :email,
              :phone,
              :birthdate_start_date,
              :birthdate_end_date)
  end
end
