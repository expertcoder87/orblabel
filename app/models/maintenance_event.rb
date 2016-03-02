class MaintenanceEvent < ActiveRecord::Base
  #attr_accessor :bike_part_type
  #validates :bike_part_type, presence: true, inclusion: { in: BikePart.part_types.values }
  #has_one :bike_part

  has_attached_file :maintenance_receipt_image
  
  validates_attachment_content_type :maintenance_receipt_image, :content_type => /\Aimage\/.*\Z/

  belongs_to :store
  
  has_many :bike_parts
  
end
