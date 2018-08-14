module Erp::Popups
  class Popup < ApplicationRecord
    include Erp::CustomOrder
		
    belongs_to :creator, class_name: 'Erp::User'
    
    validates :name, :content, presence: true
    
    # Filters
    def self.filter(query, params)
      params = params.to_unsafe_hash
      and_conds = []

			#filters
			if params["filters"].present?
				params["filters"].each do |ft|
					or_conds = []
					ft[1].each do |cond|
						or_conds << "#{cond[1]["name"]} = '#{cond[1]["value"]}'"
					end
					and_conds << '('+or_conds.join(' OR ')+')' if !or_conds.empty?
				end
			end

      #keywords
      if params["keywords"].present?
        params["keywords"].each do |kw|
          or_conds = []
          kw[1].each do |cond|
            or_conds << "LOWER(#{cond[1]["name"]}) LIKE '%#{cond[1]["value"].downcase.strip}%'"
          end
          and_conds << '('+or_conds.join(' OR ')+')'
        end
      end

      # join with table
      #query = query.joins(:category)

      # join with users table for search creator
      query = query.joins(:creator)

      query = query.where(and_conds.join(' AND ')) if !and_conds.empty?

      return query
    end

    def self.search(params)
      query = self.all
      query = self.filter(query, params)

      # order
      if params[:sort_by].present?
        order = params[:sort_by]
        order += " #{params[:sort_direction]}" if params[:sort_direction].present?

        query = query.order(order)
      end

      return query
    end
    
    STATUS_ACTIVE = 'active'
    STATUS_INACTIVE = 'inactive'
    
    # set status
		def set_active
			update_attributes(status: Erp::Popups::Popup::STATUS_ACTIVE)
		end

		def set_inactive
			update_attributes(status: Erp::Popups::Popup::STATUS_INACTIVE)
		end
		
		# check status
		def is_active?
			return self.status == Erp::Popups::Popup::STATUS_ACTIVE
		end
		
		def is_inactive?
			return self.status == Erp::Popups::Popup::STATUS_INACTIVE
		end
		
		# get newest popup
    def self.get_newest_popup
      query = self.where(status: Erp::Popups::Popup::STATUS_ACTIVE)
      query = query.order('erp_popups_popups.custom_order ASC')
      return query.last
    end
    
  end
end
