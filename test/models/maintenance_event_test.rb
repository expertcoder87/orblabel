require 'test_helper'

class MaintenanceEventTest < ActiveSupport::TestCase
  def setup
    @maintenanceEvent = MaintenanceEvent.new(bike_part_type: BikePart.part_types[:fork])
  end

  test "should be valid" do
    assert @maintenanceEvent.valid?
  end

  test "type should be present" do
    @maintenanceEvent.bike_part_type = -1
    assert @maintenanceEvent.invalid?
  end
end
