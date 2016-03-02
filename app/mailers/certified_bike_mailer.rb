class CertifiedBikeMailer < ApplicationMailer

	def certified_bike_confirmation(bike)
		@bike = bike
 	    mail from: 'victoriobn+orblabel@gmail.com',:to => bike.email, :subject => "Request For Vender bicicleta"
	end

end
