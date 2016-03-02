class SessionsController < Devise::SessionsController

	def create
		resource = Store.find_for_database_authentication(email: params[:store][:email])
		if resource.present?
			  resource_email = resource.email
			 	return invalid_login_attempt unless resource
				if resource.valid_password?(params[:store][:password])
					resource.skip_confirmation!
					if (resource.status == true).present?  
			 			sign_in("store", resource)
				 			if resource.roles.first.name == "Store_Admin"
				 				redirect_to admin_store_path
				 			else
				 				redirect_to bikes_path
				 			end
			 		else
			 			flash.notice = "Os dados da sua conta ainda não foram validados"
			 			redirect_to :back
			 		end
			 	else
			 		flash.notice = "E-mail ou senha incorretos"
			 		redirect_to :back
			 	end
		 else
		 	flash.notice = "Usuário não existe. Por favor, solicite uma conta"
		 	redirect_to :back
		 end	
	end

	def destroy
		resource = Store.find_for_database_authentication(email: current_store.email)
		sign_out(resource)
		redirect_to new_store_session_path
	end

	protected

	 def invalid_login_attempt
    	warden.custom_failure!
    	flash.notice = "E-mail ou senha incorretos"
    	redirect_to :back
    end
end

