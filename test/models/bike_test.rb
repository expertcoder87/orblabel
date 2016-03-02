require 'test_helper'

class BikeTest < ActiveSupport::TestCase
  def setup
    @bike = Bike.new(brand: "mybrand", model: "mymodel",
    size: Bike.size_types[:small], building_date: Date.today,
    serial_number: "1323546", certification: "12345678")
  end

  test "should be valid" do
    assert @bike.valid?
  end

  test "brand should be present" do
    @bike.brand = ""
    assert_not @bike.valid?
  end

  test "model should be present" do
    @bike.model = ""
    assert_not @bike.valid?
  end

  test "size should be present" do
    @bike.size = nil
    assert_not @bike.valid?
  end

  test "size should be valid" do
    # invalid size
    @bike.size = 10
    assert_not @bike.valid?
  end

  test "building_date should be present" do
    @bike.building_date = ""
    assert_not @bike.valid?
  end

  test "serial_number should be present" do
    @bike.serial_number = ""
    assert_not @bike.valid?
  end

  test "certification should be present" do
    @bike.certification = ""
    assert_not @bike.valid?
  end
end
