module Erp
  module Popups
    module ApplicationHelper
      
      # popup dropdown actions
      def popup_dropdown_actions(popup)
        actions = []
        actions << {
          text: '<i class="fa fa-edit"></i> Chỉnh sửa',
          url: erp_popups.edit_backend_popup_path(popup)
        } if can? :update, popup
        
        actions << {
          text: '<i class="fa fa-check"></i> '+t('.set_active'),
          url: erp_popups.set_active_backend_popups_path(id: popup.id),
          data_method: 'PUT',
          class: 'ajax-link',
          data_confirm: t('.set_active_confirm')
        } if can? :set_active, popup
        
        actions << {
          text: '<i class="fa fa-remove"></i> '+t('.set_inactive'),
          url: erp_popups.set_inactive_backend_popups_path(id: popup),
          data_method: 'PUT',
          class: 'ajax-link',
          data_confirm: t('.set_inactive_confirm')
        } if can? :set_inactive, popup
        
        actions << {divider: true} if can? :destroy, popup
        
        actions << {
          text: '<i class="fa fa-trash"></i> '+t('.delete'),
          url: erp_popups.backend_popup_path(popup),
          data_method: 'DELETE',
          class: 'ajax-link',
          data_confirm: t('.delete_confirm')
        } if can? :destroy, popup
        
        erp_datalist_row_actions(
          actions
        )
      end
      
    end
  end
end
