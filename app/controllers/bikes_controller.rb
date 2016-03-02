class BikesController < ApplicationController
	before_filter :store_authentication,only: [:new, :show, :edit, :index,:buscar_bicicleta,:create,:vender_bicicleta,:register_new_piece,:peca_antiga_details,:destroy,:update]
	before_filter :store_role,only: [:new,:show, :edit, :index,:buscar_bicicleta,:create,:certified_bikes,:destroy]
	skip_before_filter :verify_authenticity_token

	#Store Page Bike CRUD Operation 
	def new
		@bike = Bike.new
		@bike_parts = @bike.bike_parts.new
		@store = Store.find_by_id(@store.id)
		render :layout => 'store_application'
	end


	def show
		@bike = Bike.find(params[:id])
		@store = Store.find_by_id(@store.id)
		@bike_parts = @bike.bike_parts
		@bike_part = @bike.bike_parts.new
		@certified_bikes = UncertifiedBike.find_by_bike_id(params[:id])
		render :layout => 'store_application'
	end

	
	def edit
		@bike = Bike.find(params[:id])
		if @store.roles.first.name == "Store_Admin"
			@bike_owner = UncertifiedBike.find_by_bike_id(@bike)
		end
		render :layout => 'store_application'
	end


	def index
		@bikes = @store.bikes.all
		render :layout => 'store_application'
	end
	
	def cpf_check
		if (params[:cpf]).present?
			if !CPF.valid?(:cpf=>params[:cpf])
				@cpf_invalid = !CPF.valid?(:cpf=>params[:cpf])
			elsif CPF.valid?(:cpf=>params[:cpf])
				@cpf_valid = CPF.valid?(:cpf=>params[:cpf])
		    respond_to do |format|
				format.html	
				format.js
			 end
			end
		end
	end

	def buscar_bicicleta
		if Bike.find_by_certification(params[:bike_search]).present?
			@bikes = Bike.where("certification like ?", "%#{params[:bike_search]}%").order(:id)
		elsif Bike.find_by_brand(params[:bike_search]).present?
			@bikes = Bike.where("brand like ?", "%#{params[:bike_search]}%").order(:id)
		elsif Bike.find_by_model(params[:bike_search]).present?
			@bikes = Bike.where("model like ?", "%#{params[:bike_search]}%").order(:id)		
		elsif Bike.find_by_serial_number(params[:bike_search]).present?
			@bikes = Bike.where("serial_number like ?", "%#{params[:bike_search]}%").order(:id)
		elsif UncertifiedBike.find_by_cpf(params[:bike_search]).present?
			uncertified_bike = UncertifiedBike.find_by_cpf(params[:bike_search]).bike_id
			@bikes = Bike.where("(id::text LIKE ?)", "%#{uncertified_bike}").all.order(:id)
		else
			flash.notice = "Nenhuma bicicleta encontrada"
			@bikes = Bike.all.order(:id)
		end
		render :layout => 'store_application'
	end


	def create
	 @store = Store.find_by_id(@store.id)
	 @bike = @store.bikes.new(bike_params)
		if @bike.save
		  redirect_to bike_path(@bike.id)
		else
			redirect_to :back
		end
	end


	def update
		@bike = Bike.find(params[:id])
		@bike.update_attributes(bike_params)
		if params[:commit] == "Edit"
		   redirect_to :back
		elsif params[:commit] == "Gerar certificado"
		   n=11;
		   certificate = Array.new(n){[*"A".."Z", *"0".."9"].sample}.join
	   		if !@bike.certification.present?
	   			@bike.update_attributes(:certification=>certificate)
	   				redirect_to :back
	   		else
	   			flash.notice = "Cerification Already Assign"
	   				redirect_to :back
	   		end
	    else
				redirect_to bike_path(@bike.id)
		end
	end


	def destroy
		@bike = Bike.find(params[:id])
		@bike.destroy
		redirect_to :back
	end

	def bike_destroy
		@bike = Bike.find(params[:id])
		@bike.destroy
		redirect_to :back
	end



	# Certified Bike Methods


	def vender_bicicleta
		@store_id = Store.find_by_email(params[:email]).id
		@bike = Bike.find_by_id(params[:bike_serial_number][:bike_id])
		if @bike.update_attributes(:store_id=>@store_id)
			flash.notice = "ATENÇÃO: Clicando em Prosseguir, o certificado dessa bicicleta será transferido para o novo prorietário e ele receberá um novo código de acesso por e-mail. Você não conseguirá mais acessar essa bicicleta como seu proprietário."  
		    redirect_to :back
	    else
	    	flash.notice = "Invalid Request"
			redirect_to :back
	    end
	   BikeMailer.bike_confirmation(params[:email]).deliver_now
	end

	
	def certified_bikes
		@bike = Bike.find(params[:id])
		@store = Store.find_by_id(current_store.id)
		@bikes_store = @store.bikes
		@transfered_bike = UncertifiedBike.find_by_bike_id(params[:id])
		if @transfered_bike.present?
			bike_user = @transfered_bike.email
			current_user = current_store.email
			if (current_user == bike_user).present?
				@bike_owner_store_own = Bike.find(params[:id])
			end
		end
		if params[:commit] == "Alertar Roubo"
			@bike.update_attributes(:robery_alert=>1)
		elsif params[:commit] == "Cancelar Alerta de Roubo"
			@bike.update_attributes(:robery_alert=>0)
		end
		@robery = Bike.find(@bike).robery_alert
		@bike_maintenance_events = MaintenanceEvent.where(:bike_id=>@bike.id)
		@bike_part_maintenace_events = BikePart.where(:bike_id=>@bike.id)
		render :layout => 'store_application'
	end


	def register_new_piece
		@store = Store.find_by_id(@store.id)
		@bikes_store = @store.bikes
		if params[:bike_id].present?
			@bike = Bike.find(params[:bike_id])
			@bike_part = @bike.bike_parts
		end
		respond_to do |format|
			format.js
		end
	end


	def peca_antiga_details
		@bikes_store = @store.bikes
		if params[:bike_id].present? && params[:bike_part_type].present?
			@bike_part_types = BikePart.where(:bike_id=>params[:bike_id],:bike_part_type=>params[:bike_part_type].to_i)
		end
		respond_to do |format|
			format.js
		end
	end


	def access_code
		@access_code = p SecureRandom.hex(10)
		@bike = Bike.find_by_id((Bike.find_by_serial_number(params[:id]).id))
		if !@access_code.present?
			@bike.update_attributes(:access_code=>@access_code)
		else
			flash.notice = "Access Code already Existed For This Bike"
		end
	end

	# UnCertified Bike Methods

	def uncertified_bikes
		@bike = Bike.find(params[:id])
		if params[:uncertified_bike_id].present?
			@uncertified_bike = UncertifiedBike.find_by_id(params[:uncertified_bike_id].to_i)
		end
		render :layout => 'store_application'
	end

	def vender_bicicleta_model
	@uncertified_bike = UncertifiedBike.find(params[:uncertified_bike_id])
	respond_to do |format|
		format.js
		end
    end
	# Bike Page For Guest User

	def certified
		if Bike.find_by_certification(params[:certification]).present?
			@certified_bike = Bike.find_by_certification(params[:certification])
			@certified_bike_id = Bike.find_by_certification(params[:certification]).id
				if (Bike.find(@certified_bike_id).store_id).present?
					store_id = Bike.find(@certified_bike_id).store_id
					@store_owner = Store.find(store_id)
				end
			@bike_owner = UncertifiedBike.find_by_bike_id(@certified_bike_id)
			@bike_parts = @certified_bike.bike_parts
			@maintenance_events = MaintenanceEvent.where(:bike_id=>@certified_bike_id)
			@date_of_sales = UncertifiedBike.where(:bike_id=>@certified_bike_id)
			if params[:access_code].present?
				if (@bike_owner.access_code == params[:access_code]).present?
					redirect_to acesso_do_proprietario_path(@bike_owner.id)
				else
					redirect_to :back
				end		
			elsif params[:cpf].present?
				if (@bike_owner.email == params[:email]) && (@bike_owner.cpf == params[:cpf])
					@access_code = p SecureRandom.hex(10)
					@bike_owner.update_attributes(:email=>params[:email],:access_code=>@access_code)
					UncertifiedBikeMailer.new_access_code_bike(@bike_owner).deliver_now
					redirect_to :back
				else
					flash.notice == "Detalhes Inválidos"
					redirect_to :back
				end	
			else
				@bike = Bike.find_by_certification(params[:certification])
				@robery = @bike.robery_alert
			end
		else
			redirect_to root_url
		end
	end


	def acesso_do_proprietario
		@bike_owner = UncertifiedBike.find_by_id(params[:id])
		@bike = @bike_owner.bike_id
		@bike_details = Bike.find(@bike)
	end

	def certified_bike_owner
		@bike_owner = UncertifiedBike.find_by_id(params[:id])
		@bike = @bike_owner.bike_id
		@bike_details = Bike.find(@bike)
		if params[:commit] == "Alertar Roubo"
			@bike_id = @bike_owner.bike_id
			@bike = Bike.find(@bike_id)
			@bike.update_attributes(:robery_alert=>1)
			redirect_to :back
		elsif params[:commit] == "Cancelar Alerta de Roubo"
			@bike_id = @bike_owner.bike_id
			@bike = Bike.find(@bike_id)
			@bike.update_attributes(:robery_alert=>0)
			redirect_to :back
	    else
	    	@bike_id = @bike_owner.bike_id
	    	@maintenance_events = MaintenanceEvent.where(:bike_id=>@bike_id)
	    	@date_of_sales = UncertifiedBike.where(:bike_id=>@bike_id)
			@robery = Bike.find(@bike_id).robery_alert
		end

	end

	# Requested No Of Certificate
	def requisitar_certificados
		@store = Store.find(current_store.id)
		@store.update_attributes(:no_of_certificate=>params[:no_of_certificate])
		redirect_to :back
	end


	# Bike Page For Admin
	def admin_bike
		@bikes = Bike.all
		render :layout => 'store_application'
	end

	def admin_maintenance_events
		@maintenance_events =  MaintenanceEvent.where(:bike_id=>params[:id])
		render :layout => 'store_application'
	end

	def change_certificate
		if params[:bike_id].present?
			@bike = Bike.find(params[:bike_id])
			@bike.update_attributes(:certification=>params[:bike][:certification])
			uncertified_bike = UncertifiedBike.find_by_bike_id(@bike.id)
			certified_bike = CertifiedBike.find_by_bike_id(@bike.id)
			if uncertified_bike.present?
				uncertified_bike_id = UncertifiedBike.find_by_bike_id(@bike.id).id
				uncertified = UncertifiedBike.find(uncertified_bike_id)
				uncertified.update_attributes(:certification=>params[:bike][:certification],:certification_confirm=>params[:bike][:certification])
			elsif certified_bike.present?
				uncertified_bike_id = UncertifiedBike.find_by_bike_id(@bike.id).id
				uncertified = UncertifiedBike.find(uncertified_bike_id)
				uncertified.update_attributes(:certification=>params[:bike][:certification],:certification_confirm=>params[:bike][:certification])
			else
				@bike.update_attributes(:certification=>params[:bike][:certification])
			end	
			redirect_to :back
		end
	end

	def admin_certificate
		@bikes = Bike.all
		@uncertified = UncertifiedBike.all
		@certified = CertifiedBike.all
		render :layout => 'store_application'
	end

	def admin_certificate_destroy
		if Bike.find_by_certification(params[:id]).present? && UncertifiedBike.find_by_certification(params[:id]).present?
			bike_certificate = Bike.find_by_certification(params[:id]).id
			bike = Bike.find(bike_certificate)
			bike.update_attributes(:certification=>"")
			un_bike_certificate = UncertifiedBike.find_by_certification(params[:id]).id
			uncertified = UncertifiedBike.find(un_bike_certificate)
		    uncertified.update_attributes(:certification=>"",:certification_confirm=>"")
			redirect_to :back
		else
			flash.notice = "bicicleta inválido"
			redirect_to :back
		end
	end
	
	def generate_certificate
		n=11;
		@certificates = (1..30).map{Array.new(n){[*"A".."Z", *"0".."9"].sample}.join}.shuffle
		if params[:commit] == "Generate Certificate"
			n=11;
		   	@certificate = Array.new(n){[*"A".."Z", *"0".."9"].sample}.join
		elsif params[:commit] == "Generate Certificate List"
			n=11;
			@certificates = (1..30).map{Array.new(n){[*"A".."Z", *"0".."9"].sample}.join}.shuffle	
		end
		 render :layout => 'store_application'
	end

	def store_alert
		@stores = Store.all
		render :layout => 'store_application'
	end

	def generate_access_code
		if params[:commit] == "Click To Generate"
			@uncertified = UncertifiedBike.find_by_certification(params[:id]).id
			@bike = UncertifiedBike.find(@uncertified)
			@access_code = p SecureRandom.hex(10)
			@bike.update_attributes(:access_code=>@access_code)
		end
		render :layout => 'store_application'
	end

	def bike_bike_part_details
		@bike = Bike.find(params[:id])
		if params[:commit] == "Volter"
			redirect_to edit_bike_path(@bike)
		elsif params[:commit] == "CADASTRAR"
			@bike.update_attributes(:bike_registration_confirm=>true)
			redirect_to bikes_path
		elsif params[:commit] == "CANCELAR"
			@bike.destroy
			redirect_to new_bike_path
		else
			render :layout => 'store_application'
		end
	end

	private

	def bike_params
		 params.require(:bike).permit(:brand,:model,:size,:building_date,:serial_number,{:bike_parts_attributes => [:bike_part_type,:brand,:model,:building_date,:serial_number]},:bike_image)
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
		end
	end

	def store_role
		if current_store.present?
			if current_store.roles.first.name
				@role = current_store.roles.first.name
			else
				flash.notice = "A sua sessão expirou. Por favor, acesse sua conta novamente"
				redirect_to :back
			end
		else
			flash.notice = "A sua sessão expirou. Por favor, acesse sua conta novamente"
			redirect_to root_url
		end
	end

end
