module SpreePrintInvoiceExtras
  class OrderManager
    attr_reader :order

    def initialize(order)
      @order = order
    end

    def order_paid?
      order.payment_state == 'paid'
    end

    def has_invoice?
      !!invoice_id
    end

    def invoice_id
      order.invoice.try(:id)
    end

    def email_sent?
      !!order.minimax_data_json['emailed_invoice']
    end

    def manual_payment_method?
      # TODO: maybe leave this to be overridden by other gems and just return false here
      order.payments.map(&:payment_method).
      find { |pm| pm.type.in?(["Spree::PaymentMethod::BankTransfer", "Spree::PaymentMethod::PhysicalPayment"]) }
      .present?
    end
  end
end
