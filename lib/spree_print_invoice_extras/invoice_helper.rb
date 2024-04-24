require 'singleton'

module SpreePrintInvoiceExtras
  class InvoiceHelper
    include Singleton

    def create_order_invoice(order_id, send_email: true)
      order = ::Spree::Order.find(order_id)
      result = {}

      order.invoice_for_order unless order.invoice

      if send_email
        send_order_invoice_email(order, result)
      end

      result
    end

    def send_order_invoice_email(order, result)
      if order.email.present?
        begin
          ::Spree::InvoiceMailer.with(
            order_number: order.number, email: order.email
          ).order_invoice.deliver_later
          result['emailed_invoice'] = true
          result['invoice_draft'] = false
        rescue StandardError => err
          Rollbar.error(err)
        end
      end
    end

    def resend_order_invoice(order_id)
      order = ::Spree::Order.find(order_id)
      result = {}

      send_order_invoice_email(order, result)
      result
    end

    def spree_store
      ::Spree::Store.order(:id).first
    end
  end
end
