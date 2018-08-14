Erp::Ability.class_eval do
  def popups_ability(user)
    can :read, Erp::Popups::Popup
    
    can :update, Erp::Popups::Popup do |popup|
      true
    end
    
    can :set_active, Erp::Popups::Popup do |popup|
      popup.is_inactive?
    end
    
    can :set_inactive, Erp::Popups::Popup do |popup|
      popup.is_active?
    end
    
    can :destroy, Erp::Popups::Popup do |popup|
      popup.creator == user
    end
  end
end
