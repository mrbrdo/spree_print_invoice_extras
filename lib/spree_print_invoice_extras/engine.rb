module SpreePrintInvoiceExtras
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_print_invoice_extras'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
    end

    config.to_prepare &method(:activate).to_proc
  end
end
