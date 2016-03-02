class BikeMailer < ApplicationMailer
	def bike_confirmation(store)
  		@store = store
  		@bike_serial = Store.find_by_email(store).bikes.last.serial_number
 	    mail from: 'victoriobn+orblabel@gmail.com',:to => store, :subject => "Request For Vender bicicleta"
   end

end
