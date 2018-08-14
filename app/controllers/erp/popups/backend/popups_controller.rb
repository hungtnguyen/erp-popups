module Erp
  module Popups
    module Backend
      class PopupsController < Erp::Backend::BackendController
        before_action :set_popup, only: [:show, :edit, :update, :destroy,
                                         :move_up, :move_down, :set_active, :set_inactive]
        
        # POST /popups/list
        def list
          @popups = Popup.search(params).paginate(:page => params[:page], :per_page => 10)
          
          render layout: nil
        end
    
        # GET /popups/1
        def show
        end
    
        # GET /popups/new
        def new
          @popup = Popup.new
          
          if request.xhr?
            render '_form', layout: nil, locals: {popup: @popup}
          end
        end
    
        # GET /popups/1/edit
        def edit
        end
    
        # POST /popups
        def create
          @popup = Popup.new(popup_params)
          @popup.creator = current_user
          @popup.set_active

          if @popup.save
            if request.xhr?
              render json: {
                status: 'success',
                text: @popup.name,
                value: @popup.id
              }
            else
              redirect_to erp_popups.edit_backend_popup_path(@popup), notice: t('.success')
            end
          else
            if params.to_unsafe_hash['format'] == 'json'
              render '_form', layout: nil, locals: {popup: @popup}
            else
              render :new
            end
          end
        end
    
        # PATCH/PUT /popups/1
        def update
          if @popup.update(popup_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @popup.name,
                value: @popup.id
              }
            else
              redirect_to erp_popups.edit_backend_popup_path(@popup), notice: t('.success')
            end
          else
            render :edit
          end
        end
    
        # DELETE /popups/1
        def destroy
          @popup.destroy
          
          respond_to do |format|
            format.html { redirect_to erp_popups.backend_popups_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        # Active /popups/set_active?id=1
        def set_active
          authorize! :set_active, @popup
          @popup.set_active

          respond_to do |format|
          format.json {
            render json: {
            'message': t('.success'),
            'type': 'success'
            }
          }
          end
        end
        
        # Inactive /popups/set_inactive?id=1
        def set_inactive
          authorize! :set_inactive, @popup
          @popup.set_inactive

          respond_to do |format|
          format.json {
            render json: {
            'message': t('.success'),
            'type': 'success'
            }
          }
          end
        end
        
        # Move up /popups/up?id=1
        def move_up
          @popup.move_up

          respond_to do |format|
          format.json {
            render json: {
            #'message': t('.success'),
            #'type': 'success'
            }
          }
          end
        end

        # Move down /popups/up?id=1
        def move_down
          @popup.move_down

          respond_to do |format|
          format.json {
            render json: {
            #'message': t('.success'),
            #'type': 'success'
            }
          }
          end
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_popup
            @popup = Popup.find(params[:id])
          end
    
          # Only allow a trusted parameter "white list" through.
          def popup_params
            params.fetch(:popup, {}).permit(:name, :content)
          end
      end
    end
  end
end
