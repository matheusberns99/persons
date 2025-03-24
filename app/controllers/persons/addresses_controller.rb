# frozen_string_literal: true
class Persons::AddressesController < ::Persons::BaseController
  before_action :set_address, only: %i[show update destroy recover]
  before_action :authenticate_user!

  def index
    addresses = @person.addresses.apply_filter(filter_params)

    render_json(addresses, Persons::Addresses::IndexSerializer, "addresses", :ok)
  end

  def show
    render_json(@address, Persons::Addresses::ShowSerializer, "address", :ok)
  end

  def create
    address = @person.addresses.new(address_params)

    if address.save
      render_json(address, Persons::Addresses::ShowSerializer, "address", :created)
    else
      render json: { errors: address.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @address.update(address_params)
      render_json(@address, Persons::Addresses::ShowSerializer, "address", :ok)
    else
      render json: { errors: @address.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @address
      @address.update(active: false, deleted_at: Time.current)
      render json: {}, status: :ok
    else
      render json: { errors: I18n.t("errors.messages.register_not_found") }, status: :not_found
    end
  end

  def recover
    address = @person.addresses.where(active: false).find_by(id: params[:id])

    if address
      address.update(active: true, deleted_at: nil)

      render_json(address, Persons::Addresses::ShowSerializer, "address", :ok)
    else
      render json: { errors: I18n.t("errors.messages.register_not_found") }, status: :not_found
    end
  end

  private

  def set_address
    @address = @person.addresses.find_by(id: params[:id])
  end

  def address_params
    params
      .require(:address)
      .permit(:street,
              :city,
              :state,
              :postal_code,
              :country)
  end

  def filter_params
    params
      .permit(:active,
              :street,
              :city,
              :state,
              :postal_code,
              :country)
  end
end
