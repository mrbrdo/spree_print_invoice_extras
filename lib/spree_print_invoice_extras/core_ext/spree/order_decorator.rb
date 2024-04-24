module SpreePrintInvoiceExtras::CoreExt::Spree
  module OrderDecorator
    def self.prepended(base)
      base.serialize :minimax_data_json, ::JSON
      base.scope :without_invoice, -> {
        where.not("minimax_data_json LIKE ?", '%"invoice_draft":false%').
        where(shipment_state: 'shipped')
      }
      (base.whitelisted_ransackable_scopes ||= []).concat(['without_invoice'])
    end
  end
end
