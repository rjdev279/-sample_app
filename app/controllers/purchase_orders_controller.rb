class PurchaseOrdersController < ApplicationController
  before_action :find_invoice, except: %w[index destroy]
  before_action :find_purchase_order, only: %w[edit update destroy]

  def index
    @purchase_orders = PurchaseOrder.all
  end

  def new
    @purchase_order = PurchaseOrder.new(purchase_order_attrs)
  end

  def create
    @purchase_order = @invoice.purchase_orders.build(purchase_order_params)

    if @purchase_order.save
      redirect_to purchase_orders_path, notice: I18n.t('resource.created', resource: 'Purchase Order')
    else
      flash[:error] = @purchase_order.errors.full_messages.join('</br>')
      render 'new'
    end
  end

  def edit; end

  def update
    if @purchase_order.update(purchase_order_params)
      redirect_to purchase_orders_path, notice: I18n.t('resource.updated', resource: 'Purchase Order')
    else
      flash[:error] = @purchase_order.errors.full_messages.join('</br>')
      render 'edit'
    end
  end

  def destroy
    if @purchase_order.destroy
      redirect_to purchase_orders_path, notice: I18n.t('resource.destroyed', resource: 'Purchase Order')
    else
      redirect_to purchase_orders_path, notice: I18n.t('resource.deleted_error', resource: 'Purchase Order')
    end
  end

  private

  def find_invoice
    @invoice = Invoice.find(params[:invoice_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to purchase_orders_path,
                flash: { error: I18n.t('resource.not_found', resource: 'Invoice', id: params[:invoice_id]) }
  end

  def find_purchase_order
    @purchase_order = PurchaseOrder.find(params[:id])
  end

  def purchase_order_params
    params.require(:purchase_order).permit(:client_name, :amount, :tax, :vendor, :status)
  end

  def purchase_order_attrs
    @invoice.attributes.slice('client_name', 'amount', 'tax')
  end
end
