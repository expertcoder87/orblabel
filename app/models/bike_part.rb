class BikePart < ActiveRecord::Base
  enum part_type: [:Garfo, :Rodas, :Quadro]

  # attr_accessor :bike_part_type, :brand, :model, :building_date, :serial_number
  
   validates :bike_part_type, :brand, :model, :building_date, :serial_number, :presence => true
  
  # validates :bike_part_type, inclusion: { in: BikePart.part_types.values }

    belongs_to :bike
    belongs_to :maintenance_event
end
