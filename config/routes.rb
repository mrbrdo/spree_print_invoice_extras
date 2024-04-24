Spree::Core::Engine.add_routes do
  namespace :admin, path: Spree.admin_path do
    resources :invoices, only: [], controller: '/spree_print_invoice_extras/invoices' do
      post :create_invoice
    end
  end
end
