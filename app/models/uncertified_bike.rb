class UncertifiedBike < ActiveRecord::Base

   has_attached_file :receipt
  
   validates_attachment_content_type :receipt, :content_type => /\Aimage\/.*\Z/

end
