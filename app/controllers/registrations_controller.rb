class RegistrationsController < Devise::RegistrationsController
	before_filter :store_authentication,:only=> :edit

	def create
		@stores = Store.new(store_params)
		if !Store.exists?(:cnpj=>(params[:store][:cnpj]).gsub(/\W/, ''))
			if CNPJ.valid?(params[:store][:cnpj])
				if !Store.find_by_email(params[:store][:email]).present?
					@stores.skip_confirmation_notification!
					if @stores.save
						@stores.add_role "2"			
						redirect_to display_message_path(@stores.id)
						flash.notice = "Sua loja foi cadastrada com sucesso! Sua conta será ativada após aprovação por nossa equipe!!"
					else
						flash.notice = "Problemas ao solicitar conta. Por favor, confira os dados informados"
						redirect_to :back
					end
				else
					flash.notice = "Uma conta com este e-mail já existe"
					redirect_to :back
				end
			else
				flash.notice = "CNPJ inválido"
				redirect_to :back
			end
		else
			flash.notice = "Por favor cadastre-se com novo CNPJ"
			redirect_to :back
		end
	end
	
	def edit
		render :layout => 'store_application'
	end

	def update
		@store = Store.find_by_id(@store.id)
		if CNPJ.valid?(params[:store][:cnpj]) && (params[:store][:password]).present? && (params[:store][:password] == params[:store][:password_confirmation]).present?
			@store.update_attributes(store_params)
			flash.notice = "Senha alterada com sucesso"
			redirect_to store_session_path
		else
			flash.notice = "CNPJ inválido"
			redirect_to :back
		end
	end
	
	private

	def store_params
		params.require(:store).permit(:public_name,:legal_name,:cnpj,:area_code,:phone_number,:checkbox,{:address_attributes => [:street,:number,:district,:zipcode,:city,:state]},:email,:responsible_name,:password,:password_confirmation)
	end
	
	def store_authentication
		@store = Store.find_by_email(current_store.email)
		if @store.present?
		else
			flash.notice = "A sua sessão expirou. Por favor, acesse sua conta novamente"
			redirect_to :back
		end
	end
end