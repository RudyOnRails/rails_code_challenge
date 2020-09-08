require 'csv'

class OrderItem < ApplicationRecord
  SOLD = "sold"
  RETURNED = "returned"
  STATES = [SOLD, RETURNED].freeze
  validates_presence_of :order_id, :source_id, :source_type, :price

  validates :state,
            absence: true,
            if: -> { source_type != Product.name }

  validates :state,
            allow_nil: false,
            inclusion: STATES,
            if: -> { source_type == Product.name && order.building_at.present? }

  validates :quantity,
            presence: true,
            numericality: {
              greater_than: 0
            }

  belongs_to :order
  belongs_to :source,
             polymorphic: true

  def self.to_csv
    attributes = %i[email number_of_items total_revenue]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |order_item|
        csv << [order_item.order.user.email,
                order_item.order.order_items.count,
                order_item.order.total]
      end
    end
  end
end
