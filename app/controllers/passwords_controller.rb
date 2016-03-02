class PasswordsController < Devise::PasswordsController

	def create
		if Store.find_by_email(params[:store][:email]).present?
			Store.find_by_email(params[:store][:email]).email == params[:store][:email]
			StoreMailer.confirm_password(params[:store][:email]).deliver_now
			flash.notice = "Você receberá um e-mail para sua senha"
			redirect_to :back
		else
			flash.notice = "E-mail inválido"
			redirect_to :back
		end
	end
end