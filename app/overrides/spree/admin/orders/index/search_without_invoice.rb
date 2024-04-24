html = <<-HTML

  <div class="row">
    <div class="col-12">
      <%= f.field_container :without_invoice do %>
        <div class="custom-control custom-checkbox">
          <%= f.check_box :without_invoice, {checked: params[:q][:without_invoice] == '1', class: 'custom-control-input'}, '1', '0' %>
          <%= f.label :without_invoice, Spree.t(:show_only_orders_without_invoice), class: 'custom-control-label' %>
        </div>
      <% end %>
    </div>
  </div>
      HTML

if Spree.version.start_with?('4.3')
  Deface::Override.new(
    virtual_path:  'spree/admin/orders/index',
    name:          'search_without_invoice',
    insert_before: 'div[data-hook=admin_orders_index_search_buttons]',
    text: html
  )
else
  Deface::Override.new(
    virtual_path:  'spree/admin/orders/_search',
    name:          'search_without_invoice',
    insert_before: 'div[data-hook=admin_orders_index_search_buttons]',
    text: html)
end
