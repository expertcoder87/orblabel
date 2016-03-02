class Address < ActiveRecord::Base
  #attr_accessor :street, :number, :district, :zipcode, :city, :state
	validates :street, :number, :zipcode, :city, :state, :presence => true
  # validates :zipcode, zipcode: { country_code: :br }
  
  	belongs_to :store

end
