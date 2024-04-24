Rails.application.config.to_prepare do
  # Extend reloadable classes
  ::Spree::Order.send :prepend, SpreePrintInvoiceExtras::CoreExt::Spree::OrderDecorator
end
