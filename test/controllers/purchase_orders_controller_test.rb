require 'test_helper'

class PurchaseOrdersControllerTest < ActionDispatch::IntegrationTest
  let(:invoice) { create(:invoice) }
  let(:purchase_order) { create(:purchase_order, invoice: invoice) }

  test 'should get index' do
    get purchase_orders_url
    assert_response :success
  end

  test 'should get new' do
    get new_invoice_purchase_order_path(invoice_id: invoice.id)
    assert_response :success
  end

  test 'should create purchase_order' do
    assert_difference('PurchaseOrder.count') do
      post invoice_purchase_orders_path(invoice_id: invoice.id), params: {
        purchase_order: {
          client_name: 'Test Client',
          amount: 10.0,
          tax: 15,
          vendor: 'Test Vendor',
          status: 'draft'
        }
      }
    end

    assert_redirected_to purchase_orders_url
  end

  test 'should not create purchase_order' do
    assert_difference('PurchaseOrder.count', 0) do
      post invoice_purchase_orders_path(invoice_id: invoice.id), params: {
        purchase_order: {
          client_name: nil,
          amount: 10.0,
          tax: 15,
          vendor: nil,
          status: 'draft'
        }
      }
    end

    assert_equal(["Client name can't be blank", "Vendor can't be blank"], assigns(:purchase_order).errors.full_messages)
    assert_response :success
  end

  test 'should get edit' do
    get edit_invoice_purchase_order_path(invoice, purchase_order)
    assert_response :success
  end

  test 'should update purchase_order' do
    patch invoice_purchase_order_path(invoice, purchase_order), params: {
      purchase_order: { client_name: 'Updated Client Test Client' }
    }
    assert_redirected_to purchase_orders_url
  end

  test 'should destroy purchase_order' do
    PurchaseOrder.create(purchase_order.attributes.except('id'))

    assert_difference('PurchaseOrder.count', -1) do
      delete invoice_purchase_order_path(invoice, purchase_order)
    end

    assert_redirected_to purchase_orders_url
  end
end
