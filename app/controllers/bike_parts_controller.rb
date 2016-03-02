class BikePartsController < ApplicationController
	before_filter :store_authentication,only: [:register_new_bike_piece]
	before_filter :robery_alert,only: [:register_new_bike_piece]

	def register_new_bike_piece
		@maintenance_event = MaintenanceEvent.create(:maintenance_receipt_image=>params[:bike_part][:maintenance_event][:maintenance_receipt_image],:description=>params[:bike_part][:maintenance_event][:description],:bike_id=>params[:bike_id],:store_id=>@store.id)
		if BikePart.where(:bike_id=>params[:bike_id]).present? && BikePart.where(:bike_id=>params[:bike_id],:bike_part_type=>params[:bike_part][:bike_part_type].to_i).present?
			bike_part_id = BikePart.where(:bike_id=>params[:bike_id],:bike_part_type=>params[:bike_part][:bike_part_type].to_i)[0].id
			@bike_part = BikePart.find(bike_part_id)
			@bike_part.update_attributes(bike_part_params)
			@bike_part.update_attributes(:maintenance_event_id=>@maintenance_event.id)
			redirect_to :back
		else
			@bike_part_event = @maintenance_event.bike_parts.create(bike_part_params)
			@bike_part_event.update_attributes(:bike_id=>params[:bike_id])
			redirect_to :back
		end
	end

	def create
		 bike = Bike.find(params[:bike_id])
		 if !bike.bike_parts.exists?(:bike_part_type=>params[:bike_part][:bike_part_type].to_i)
		 	bike_part = bike.bike_parts.create(bike_part_params)
		 	redirect_to :back
		 else
		 	flash.notice = "por favor cadastre-se com nova peça"
		 	redirect_to :back
		 end
	end
	
	def destroy
		bike_part = BikePart.find(params[:id])
		bike_part.destroy
		redirect_to :back
	end
	
	private

		def store_authentication
			@store = Store.find_by_email(current_store.email)
			if @store.present?
			else
				flash.notice = "Session Expire Please Login !!"
			end
		end

		
		def bike_part_params
			params.require(:bike_part).permit(:bike_part_type,:brand,:model,:building_date,:serial_number)
		end


		def robery_alert
		 @bike = Bike.find(params[:bike_id])
			if @bike.robery_alert == true
				flash.notice == "Esta bicicleta tem um alerta de roubo! As funcionalidades associadas com esta bicicleta não estão disponíveis."
				redirect_to certified_bikes_path(@bike)
			end
		end
		
end