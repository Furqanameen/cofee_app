class Discount < ApplicationRecord
  has_many :combo_discounts, dependent: :destroy
  has_many :items, through: :combo_discounts  # Correct way to associate items

  enum discount_type: { percentage: 0, combo: 1 }  # Now integer-based

  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :discount_type, presence: true, inclusion: { in: Discount.discount_types.keys }
  validates :value, numericality: { greater_than_or_equal_to: 0 }, if: :percentage_discount?
  validates :condition, presence: true, if: :combo_discount?



  private

  def percentage_discount?
    discount_type == "percentage"
  end

  def combo_discount?
    discount_type == "combo"
  end
end