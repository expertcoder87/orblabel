class Bike < ActiveRecord::Base
  enum size_type: [:Pequeno, :Médio, :Grande, :Extra_Grande]

  has_attached_file :bike_image
  
  validates_attachment_content_type :bike_image, :content_type => /\Aimage\/.*\Z/

  # attr_accessor :brand, :model, :size, :building_date, :serial_number, :certification
  validates :brand, :model, :size, :building_date, :serial_number,:presence => true
  # validates :size, inclusion: { in: Bike.size_types.values }
  
  has_many :bike_parts

  accepts_nested_attributes_for :bike_parts
  
  belongs_to :store

end
