class ReportsController < ApplicationController
  def index
  end

  def coupon_users
    coupon = Coupon.includes(order_items: [order: [:user]]).find(coupon_params["id"])
    send_data(coupon.order_items.to_csv, filename: "coupon_#{coupon.name}_users_#{Time.now.strftime('%Y%m%d%H%M%S')}.csv")
  end

  private
    def coupon_params
      params.require(:coupon).permit("id")
    end
end
