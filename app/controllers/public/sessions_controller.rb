# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_customer, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # 会員の論理削除のための記述。退会後は、同じアカウントでは利用できない。
  def reject_customer
    @customer = Customer.find_by(email: params[:customer][:email])  #flash.nowはrenderのみ
    if @customer
      if @customer.valid_password?(params[:customer][:password]) && (@customer.is_active == false)
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to new_customer_session_path
      else
        flash[:notice] = "ようこそ！"
      end
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
