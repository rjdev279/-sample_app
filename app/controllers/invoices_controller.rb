class InvoicesController < ApplicationController
  before_action :find_invoice, only: %w[destroy xhr_change_client_name]

  def index
    @invoices = Invoice.all
  end

  def new
    @invoice = Invoice.new
  end

  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      redirect_to invoices_path, notice: I18n.t('resource.created', resource: 'Invoice')
    else
      flash[:error] = @invoice.errors.full_messages.join('</br>')
      render 'new'
    end
  end

  def destroy
    @invoice.destroy!

    redirect_to invoices_path, notice: I18n.t('resource.deleted_for', resource: 'Invoice', for: @invoice.client_name)
  end

  def xhr_change_client_name
    if request.get?
      render partial: 'modal--change-client-name', locals: { invoice: @invoice }
    elsif request.patch?
      @invoice.client_name = params[:invoice][:client_name]
      if @invoice.save
        render json: { id: @invoice.id, client_name: @invoice.client_name }
      else
        render json: @invoice.errors.full_messages.first
      end
    end
  end

  private

  def find_invoice
    @invoice = Invoice.find params[:id]
  end

  def invoice_params
    params.require(:invoice).permit(:client_name, :amount, :tax)
  end
end
