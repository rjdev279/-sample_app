class PurchaseOrder < ApplicationRecord
  belongs_to :invoice

  enum status: { draft: 0, paid: 1, delivered: 2 }

  validates :client_name, :amount, :vendor, :status, presence: true
  validates :amount, numericality: { greater_than: 0 }

  def total
    return (amount * (1 + (tax / 100))) unless tax&.zero?

    amount
  end
end
