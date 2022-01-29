class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_user, only: [:show, :edit, :update, :withdraw, :unsubscribe]

  def show
    @customer=current_customer
  end

  def edit
    @customer=current_customer
  end

  def update
    @customer = current_customer  #今回はcustomer_id飛ばしてないから最初からcustomer=current_customerを入れておく
    if @customer.update(customer_params)
      redirect_to customers_path
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会手続きが完了いたしました。ご利用いただき誠にありがとうございました。"
    redirect_to root_path
  end

  def ensure_correct_user
    unless customer_id=current_customer.id
    redirect_to root_path(current_customer)
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end
end
