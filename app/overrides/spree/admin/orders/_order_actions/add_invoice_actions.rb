Deface::Override.new(
  virtual_path:  'spree/admin/orders/_order_actions',
  name:          'add_invoice_actions',
  insert_after: ':last-child',
  partial: 'spree/admin/orders/invoice_order_actions'
)
