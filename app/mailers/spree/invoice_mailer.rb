module Spree
  class InvoiceMailer < BaseMailer
    def order_invoice
      @title = Spree.t('invoice_mailer.order_invoice.subject')
      @order_number = params[:order_number]
      # this is used for setting locale
      @order = Spree::Order.find_by(number: params[:order_number])
      attachments["racun-#{@order_number}.pdf"] =
        @order.invoice.pdf
      mail(to: params[:email], from: from_address, store_url: current_store.url, subject: @title)
    end
  end
end
