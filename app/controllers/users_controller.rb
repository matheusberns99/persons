# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  before_action :authenticate_user!

  def index
    users = User.apply_filter(filter_params)

    render_json(users, Users::IndexSerializer, "users", :ok)
  end

  def show
    render_json(@user, Users::ShowSerializer, "user", :ok)
  end

  def create
    user = User.new(user_params)

    if user.save
      render_json(user, Users::ShowSerializer, "user", :created)
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render_json(@user, Users::ShowSerializer, "user", :ok)
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @user
      @user.destroy
      render json: {}, status: :ok
    else
      render json: { errors: I18n.t("errors.messages.register_not_found") }, status: :not_found
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])

    return if @user

    record_not_found
  end

  def user_params
    params
      .require(:user)
      .permit(:email,
              :password,
              :password_confirmation)
  end

  def filter_params
    params
      .permit(:email)
  end
end
