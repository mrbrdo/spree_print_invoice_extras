module SpreePrintInvoiceExtras
  class InvoicesController < Spree::Admin::BaseController
    def create_invoice
      order = ::Spree::Order.find_by(number: params[:invoice_id])

      if params[:invoice_action] == 'unlink'
        order.minimax_data_json = {}
      else
        case params[:invoice_action]
        when 'resend'
          minimax_data_result = SpreePrintInvoiceExtras::InvoiceHelper.instance.resend_order_invoice(order.id)
          success_message = "Račun ponovno poslan po e-pošti."
        when 'create_and_send'
          minimax_data_result = SpreePrintInvoiceExtras::InvoiceHelper.instance.create_order_invoice(order.id, send_email: true)
          success_message = "Račun ustvarjen in izdan, ter poslan po e-pošti."
        when 'mark_invoice_finalized'
          minimax_data_result = { 'invoice_draft' => false }
          success_message = "Podatki posodobljeni"
        else
          fail "No invoice_action given!"
        end
        if minimax_data_result == false
          flash[:error] = Spree.t(:'admin.minimax.invoice_action_error')
        else
          flash[:success] = success_message
          order.minimax_data_json = order.minimax_data_json.merge(minimax_data_result)
        end
      end
      order.save!

      redirect_back fallback_location: spree.edit_admin_order_url(id: order.number)
    end
  end
end
