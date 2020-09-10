require 'test_helper'

include ActionView::Helpers::NumberHelper

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "::sales_by_date" do
    assert_equal "$19.98", number_to_currency(Product.sales_by_date(10.years.ago..1.years.from_now).
      first.order_items.sum{ |oi| oi.quantity * oi.price })
    assert_equal 1, Product.sales_by_date(10.years.ago..1.years.from_now).length
  end
end
