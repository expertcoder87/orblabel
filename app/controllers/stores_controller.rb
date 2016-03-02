class StoresController < ApplicationController
 	skip_before_filter :verify_authenticity_token,only: [:store_destroy]  

	def index
		@stores = Store.all.page(params[:page]).per(10)
	end
	
	def show
		if current_store.present?
		    @resource = Store.find_for_database_authentication(email: current_store.email)
			@store = Store.find_by_id(@resource.id)
			@role = @store.roles.first.name
			render :layout => 'store_application'
		else
			flash.notice = "A sua sessão expirou. Por favor, acesse sua conta novamente"
		end
	end

	def check_cnpj_cpf
		if params[:cnpj].present?  
			if !CNPJ.valid?(params[:cnpj])
				@cnpj_invalid = !CNPJ.valid?(params[:cnpj])
			elsif Store.exists?(:cnpj=>params[:cnpj].gsub(/\W/, ''))
				@cnpj_existence = Store.exists?(:cnpj=>params[:cnpj].gsub(/\W/, ''))
			elsif CNPJ.valid?(params[:cnpj])
				@cnpj_valid = CNPJ.valid?(params[:cnpj])
			end
		elsif params[:email].present?
			if Store.exists?(:email=>params[:email])
				@email_existence = Store.exists?(:email=>params[:email])
			elsif !Store.exists?(:email=>params[:email])
				@email_nonexistence = !Store.exists?(:email=>params[:email])		
			end
		end
	   	respond_to do |format|
			format.js
		end
	end

	# Store Recover Passwords

	def recover_password
		@store_id = Store.find_by_email(params[:id]+"."+params[:format]).id
		@store = Store.find(@store_id)
	end

	def reset_password
		@store = Store.find(params[:store_id].to_i)
		if @store.present?
			if (params[:store][:password]).present?
					if params[:store][:password] == params[:store][:password_confirmation]	
					 	@store.update_attributes(:password => params[:store][:password],:password_confirmation=> params[:store][:password_confirmation])
				 		flash.notice = "Senha criada com sucesso"
				 		redirect_to :back
				 	else
				 		flash.notice = "Senha e Confirmação de senha não combinam"
				 		redirect_to :back
				 	end
			else
				flash.notice = "Senha inválida"
				redirect_to :back
			end
		else
			flash.notice = "Loja inválido"
			redirect_to :back
		end
	end

	# Admin Page Store Methods

	def admin_store
		@store = current_store
		@stores = Store.all.page(params[:page]).per(10)
		render :layout => 'store_application'
	end

	def registration_new
		@store = Store.new
		@address = @store.build_address
	end

	def admin_sign_up
		@stores = Store.new(store_params)
	 	 if !(Store.find_by_email(params[:store][:email])).present?
			if (params[:store][:password]).present? && CPF.valid?(params[:store][:cnpj]).present?
				if(params[:store][:password] == params[:store][:password_confirmation])
					 if @stores.save
					 	@stores.add_role "2" 	
						redirect_to admin_store_path
					 else
					 	flash.notice = "Sua loja não foi registrado com sucesso! Você pode registrado com detalhes inválidos !"
					 	redirect_to :back
					 end
				else
					flash.notice = "Senha e Confirmação de senha não combinam"
					redirect_to :back
				end
			else
				flash.notice = "Detalhes inválidos"
				redirect_to :back
			end
		else
			flash.notice = "Uma conta com este e-mail já existe"
			redirect_to :back
		end
	end

	def registration_edit
		@store = Store.find(params[:id])
		@address = @store.address
		render :layout => 'store_application'
	end

	def store_update
		@store = Store.find_by_id(params[:store_id])
		@store.update_attributes(store_params)
		redirect_to admin_store_path
	end

	def store_destroy
		@store = Store.find(params[:id])
		@store.destroy
		redirect_to :back
	end

	def sign_up_mail
		@resource = Store.find(params[:id])
		if params[:commit] == "Desativar"
			@resource.update_attributes(:status=>"FALSE")
			redirect_to :back
		else
			@resource.update_attributes(:status=>"TRUE")
			StoreMailer.registration_confirmation(@resource).deliver_now
			redirect_to :back
		end
	end

	# Static Contact page
	def contact
		if (params[:contact][:communication_check] == "1").present? 
			contact = Contact.create(contact_param)
			StoreMailer.contact_communication_confirmation(contact).deliver_now
			flash.notice = "Detalhes de contato publicados com sucesso , você receberá correio em breve"
			redirect_to :back
		else
			contact = Contact.create(contact_param)
			flash.notice = "Detalhes de contato lançado com êxito"
			redirect_to :back
		end
	end

	def display_message
		@store = Store.find(params[:id])
	end
	
	private

	def store_params
		params.require(:store).permit(:public_name,:legal_name,:cnpj,:area_code,:phone_number,{:address_attributes => [:street,:number,:district,:zipcode,:city,:state]},:email,:responsible_name,:password,:password_confirmation)
	end

	def contact_param
		params.require(:contact).permit(:name,:email,:phone_number,:description,:communication_check)
	end

end
