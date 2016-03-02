class UncertifiedBikeMailer < ApplicationMailer

	def uncertified_bike_confirmation(bike)
		 @bike = bike
		 @receipt = bike.receipt_file_name
		 attachments[@receipt]=File.read(("#{Rails.root}"+"/public" + bike.receipt.url.split("?").first))
 	     mail from: 'victoriobn+orblabel@gmail.com',:to => bike.email, :subject => "Request For Vender bicicleta"
	end

	def certified_bike_confirmation(bike)
		@bike = bike
		@receipt = bike.receipt_file_name
		attachments[@receipt]=File.read(("#{Rails.root}"+"/public" + bike.receipt.url.split("?").first))
 	    mail from: 'victoriobn+orblabel@gmail.com',:to => bike.email, :subject => "Request For Vender bicicleta"
	end

	def new_access_code_bike(access_code)
		@access_code = access_code
		mail from: 'victoriobn+orblabel@gmail.com',:to => access_code.email, :subject => "New Access Code Generated For Bike"
	end

	def transfer_bicicleta_confirmation(bike)
		@bike = bike
		mail from: 'victoriobn+orblabel@gmail.com',:to => bike.email, :subject => "Request For Transfer bicicleta"
	end

end
