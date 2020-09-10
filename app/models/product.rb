require 'csv'

class Product < ApplicationRecord
  validates_presence_of :name

  validates   :sku,
              presence: true,
              uniqueness: true

  validates   :msrp,
              presence: true,
              numericality: {
                greater_than_or_equal_to: 0
              },
              format: {
                with: /\A-?\d+\.?\d{0,2}\z/,
                message: 'only accepts 2 decimal places.'
              }

  validates   :cost,
              presence: true,
              numericality: {
                greater_than_or_equal_to: 0
              },
              format: {
                with: /\A-?\d+\.?\d{0,2}\z/,
                message: 'only accepts 2 decimal places.'
              }

  has_many :order_items,
           as: :source


  def self.to_csv
    attributes = %i[name sold_count revenue]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |product|
        csv << [product.name,
                product.order_items.count,
                ActionController::Base.helpers.number_with_precision(product.order_items.sum{ |oi| oi.quantity * oi.price }, precision: 2)]
      end
    end
  end
end
