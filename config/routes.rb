Erp::Popups::Engine.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
		namespace :backend, module: "backend", path: "backend/popups" do
      resources :popups do
        collection do
          post 'list'
					get 'dataselect'
					put 'set_active'
					put 'set_inactive'
					put 'move_up'
          put 'move_down'
        end
      end
      #resources :categories do
      #  collection do
      #    post 'list'
      #    get 'dataselect'
      #    delete 'delete_all'
      #    put 'archive_all'
      #    put 'unarchive_all'
      #    put 'archive'
      #    put 'unarchive'
      #  end
      #end
    end
  end
end
