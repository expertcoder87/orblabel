require 'test_helper'

class BikePartTest < ActiveSupport::TestCase
  def setup
    @bike_part = BikePart.new(bike_part_type: BikePart.part_types[:fork], brand: "mybrand",
    model: "mymodel", building_date: Date.today,
    serial_number: "1323546")
  end

  test "should be valid" do
    assert @bike_part.valid?
  end

  test "type should be present" do
    @bike_part.bike_part_type = -1
    assert_not @bike_part.valid?
  end

  test "type should be valid" do
    # invalid type
   @bike_part.bike_part_type = 10
    assert_not @bike_part.valid?
  end

  test "brand should be present" do
    @bike_part.brand = ""
    assert_not @bike_part.valid?
  end

  test "model should be present" do
    @bike_part.model = ""
    assert_not @bike_part.valid?
  end

  test "building_date should be present" do
    @bike_part.building_date = ""
    assert_not @bike_part.valid?
  end

  test "serial_number should be present" do
    @bike_part.serial_number = ""
    assert_not @bike_part.valid?
  end
end
