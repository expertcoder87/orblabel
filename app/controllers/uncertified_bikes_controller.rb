class UncertifiedBikesController < ApplicationController
	before_filter :store_authentication,only: [:new,:create,:vender_bicicleta]
	# before_filter :robery_alert,only: [:vender_bicicleta]

	def new
		@uncertified_bike = UncertifiedBike.new
	end
	
	def create
		@bike = Bike.find(params[:bike_id])
		if (params[:uncertified_bike][:certification] == params[:uncertified_bike][:certification_confirm]).present? && (CPF.valid?(params[:uncertified_bike][:cpf])).present?
			@uncertified_bike = UncertifiedBike.create(uncertified_bike_params)
			@check = @uncertified_bike.update_attributes(:bike_id=>params[:bike_id])
			@bike.update_attributes(:certification=>params[:uncertified_bike][:certification])	
			redirect_to uncertified_bike_path(uncertified_bike_id: @uncertified_bike.id)
		else
			flash.notice = "Erro no CPF ou Certificação"
			redirect_to :back
		end
	end

	def update
	    if params[:uncertified_bike_id].present? 
			@uncertified_bike = UncertifiedBike.find_by_id(params[:uncertified_bike_id].to_i)
			@access_code = p SecureRandom.hex(10)
			@uncertified_bike.update_attributes(:access_code=>@access_code)
			UncertifiedBikeMailer.uncertified_bike_confirmation(@uncertified_bike).deliver_now
			if @bike = Bike.find_by_id(params[:bike_id].to_i)
				@bike.update_attributes(:store_id=>"",:certification=>@uncertified_bike.certification)
			end
			redirect_to bikes_path
		elsif params[:owner_id].present?
			@bike_owner = UncertifiedBike.find_by_id(params[:owner_id])
			# @bike_owner.update_attributes(uncertified_bike_params)
			redirect_to proprietario_bicicleta_cerified_path(@bike_owner)
		else
			flash.notice = "Detalhes inválidos"
			redirect_to :back
		end
	end

	def vender_bicicleta
		if params[:bike_id].present?
			@bike = Bike.find(params[:bike_id])
			@uncertified_bike = UncertifiedBike.create(uncertified_bike_params)
			@access_code = p SecureRandom.hex(10)
			@uncertified_bike.update_attributes(:access_code=>@access_code,:certification=>@bike.certification,:certification_confirm=>@bike.certification,:bike_id=>@bike.id)
			UncertifiedBikeMailer.certified_bike_confirmation(@uncertified_bike).deliver_now
			@bike.update_attributes(:store_id=>"")
			redirect_to bikes_path
	    end
	end

	def vender_bicicleta_model_update
		uncertified_bike = UncertifiedBike.find(params[:uncertified_bike_id])
		uncertified_bike.update_attributes(uncertified_bike_params)
		redirect_to :back
	end

	def transfer_bicicleta
     	if params[:owner_id].present? && params[:uncertified_bike][:email].present?
	     		@bike = UncertifiedBike.find(params[:owner_id])
	     		@bike.update_attributes(:access_code=>"")
	     		@bike.update_attributes(uncertified_bike_params)
		     		if Store.find_by_email(params[:uncertified_bike][:email])
		     			@store = Store.find_by_email(params[:uncertified_bike][:email]).id
			     		@store_bike = Bike.find(@bike.bike_id)
			     		@store_bike.update_attributes(:store_id=>@store)
			     		n=11;
			   			certificate = @bike.certification
		     			@store_bike.update_attributes(:certification=>certificate)
		     			@bike.update_attributes(:certification=>certificate,:certification_confirm=>certificate)
			     	else
			     		@store_bike = Bike.find(@bike.bike_id)
			     		n=11;
			   			certificate = @bike.certification
		     			@store_bike.update_attributes(:store_id=>"",:certification=>certificate)
		     			@bike.update_attributes(:certification=>certificate,:certification_confirm=>certificate)
			     	end
	     		@access_code = p SecureRandom.hex(10)
	     		@bike.update_attributes(:access_code=>@access_code)
	     		UncertifiedBikeMailer.transfer_bicicleta_confirmation(@bike).deliver_now
	     		redirect_to root_path
     	end
     end

private

	def uncertified_bike_params
		params.require(:uncertified_bike).permit(:name,:cpf,:email,:email_confirmation,:area_code,:cell_phone_number,:street,:number,:district,:zipcode,:city,:state,:certification,:certification_confirm,:selling_price,:access_code,:receipt)
	end

	def store_authentication
		if current_store.present?
			@store = Store.find_by_email(current_store.email)
				if @store.present?
				else
					flash.notice = "A sua sessão expirou. Por favor, acesse sua conta novamente"
					redirect_to root_url
				end
		else
			flash.notice = "A sua sessão expirou. Por favor, acesse sua conta novamente"
			redirect_to root_url
		end
	end

	# def robery_alert
	# 	@bike = Bike.find(params[:bike_id])
	# 	if @bike.robery_alert == true
	# 		flash.notice == "ATENÇÃO: O proprietário dessa bicicleta registrou um alerta de roubo para ela"
	# 		redirect_to certified_bikes_path(@bike)
	# 	end
	# end

end






	