class MaintenancesEventsController < ApplicationController
	before_filter :store_authentication,only: [:create]
	before_filter :store_role,only: [:create]
	before_filter :robery_alert,only: [:create]


	# Store Owner Maintenance Operation
	def create
		@store = Store.find_by_id(@store.id)
			@maintenance_event = @store.maintenance_events.create(maintenance_events_params)
			if @maintenance_event.present?
				@maintenance_event.update_attributes(:bike_id=>params[:bike_id])		
				redirect_to :back
			else	
				flash.notice = "Nenhuma manutenção registrada"
				redirect_to :back
			end	
	end

	def update
		if params[:event_id].present?
			@maintenance_event = MaintenanceEvent.find(params[:event_id])
			@maintenance_event.update_attributes(maintenance_events_params)
			redirect_to :back
		else
			redirect_to :back
		end
	end

	# Store Admin Maintenance Event

	def admin_create_event
			@maintenance_event = MaintenanceEvent.create(maintenance_events_params)
			if @maintenance_event.present? && params[:bike_id].present?
				@maintenance_event.update_attributes(:bike_id=>params[:bike_id])		
				redirect_to :back
			else	
				flash.notice = "Nenhuma manutenção registrada"
				redirect_to :back
			end	
	end
	

	private

	def maintenance_events_params
		params.require(:maintenance_event).permit(:description,:maintenance_receipt_image)
	end

	def store_authentication
		if current_store.present?
			@store = Store.find_by_email(current_store.email)
			if @store.present?
			else
				flash.notice = "A sua sessão expirou. Por favor, acesse sua conta novamente"
			end
		else
			flash.notice = "A sua sessão expirou. Por favor, acesse sua conta novamente"
			redirect_to root_url
		end
	end

	def store_role
		@role = current_store.roles.first.name
	end

	def robery_alert
		@bike = Bike.find(params[:bike_id])
		if @bike.robery_alert == true
			flash.notice == "Esta bicicleta tem um alerta de roubo! As funcionalidades associadas com esta bicicleta não estão disponíveis."
			redirect_to certified_bikes_path(@bike)
		end
	end
end