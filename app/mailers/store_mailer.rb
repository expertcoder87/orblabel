class StoreMailer < ApplicationMailer

	def confirm_password(store)
		@store = store
		mail from: 'victoriobn+orblabel@gmail.com',:to => store, :subject => "Request For Change Password"
	end

	def registration_confirmation(resource)
		@resource = resource
		mail from: 'victoriobn+orblabel@gmail.com',to: resource.email, subject: 'Detalhes de Ativação'
	end

	def contact_communication_confirmation(contact)
		@contact = contact
		mail from: 'victoriobn+orblabel@gmail.com',to: contact.email, subject: 'Contact Information'
	end

end