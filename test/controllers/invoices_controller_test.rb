require 'test_helper'

class InvoicesControllerTest < ActionDispatch::IntegrationTest
  let(:invoice) { create(:invoice) }

  test 'should get index' do
    get invoices_url
    assert_response :success
  end

  test 'should get new' do
    get new_invoice_path
    assert_response :success
  end

  test 'should create invoice' do
    assert_difference('Invoice.count') do
      post invoices_path, params: {
        invoice: {
          client_name: 'Test Client',
          amount: 10.0,
          tax: 15
        }
      }
    end

    assert_redirected_to invoices_url
  end

  test 'should not create invoice' do
    assert_difference('Invoice.count', 0) do
      post invoices_path, params: {
        invoice: {
          client_name: nil,
          amount: nil,
          tax: 15
        }
      }
    end

    assert_equal(["Client name can't be blank", "Amount can't be blank", 'Amount is not a number'],
                 assigns(:invoice).errors.full_messages)
    assert_response :success
  end

  test 'should destroy invoice' do
    Invoice.create(invoice.attributes.except('id'))

    assert_difference('Invoice.count', -1) do
      delete invoice_path(invoice)
    end

    assert_redirected_to invoices_url
  end

  test 'xhr_change_client_name' do
    get xhr_change_client_name_invoice_path(invoice)
    assert_response :success

    patch xhr_change_client_name_invoice_path(invoice), params: {
      invoice: { client_name: 'Updated Client Name' }
    }
    assert_response :success
  end

  test 'xhr_change_client_name' do
    patch xhr_change_client_name_invoice_path(invoice), params: { invoice: { client_name: nil } }

    assert_equal(["Client name can't be blank"], assigns(:invoice).errors.full_messages)
  end
end
