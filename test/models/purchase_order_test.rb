require 'test_helper'

class PurchaseOrderTest < ActiveSupport::TestCase
  let(:invoice) { create(:invoice) }
  let(:purchase_order) { create(:purchase_order, invoice: invoice) }

  it 'should have a client name' do
    purchase_order.client_name = nil
    refute purchase_order.valid?
  end

  it 'should have a positive amount' do
    purchase_order.amount = -10
    refute purchase_order.valid?

    purchase_order.amount = nil
    refute purchase_order.valid?

    purchase_order.amount = 5
    assert purchase_order.valid?
  end

  it 'should have a vendor' do
    purchase_order.vendor = nil
    refute purchase_order.valid?

    purchase_order.vendor = 'Some vendor name'
    assert purchase_order.valid?
  end

  it 'should have a status' do
    purchase_order.status = nil
    refute purchase_order.valid?

    purchase_order.status = 'draft'
    assert purchase_order.valid?
  end
end
