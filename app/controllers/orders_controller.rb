class OrdersController < ApplicationController
  before_action :find_order!, only: :show

  def index
    params[:q] = "*" unless params[:q].present?
    @orders = Order.search(params[:q], page: params[:page], per_page: 10)
  end

  def show
  end

  private
    def find_order!
      @order = Order.find_by!(number: params[:number])
    end
end
