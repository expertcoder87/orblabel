require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  def setup
    @address = Address.new(street: "mystreet", number: "883",
    district: "mydistrict", zipcode: "55555-100",
    city: "mycity", state: "mystate")
  end

  test "should be valid" do
    assert @address.valid?
  end

  test "street should be present" do
    @address.street = ""
    assert_not @address.valid?
  end

  test "number should be present" do
    @address.number = ""
    assert_not @address.valid?
  end

  test "district should be present" do
    @address.district = ""
    assert_not @address.valid?
  end

  test "zipcode should be present" do
    @address.district = ""
    assert_not @address.valid?
  end

  test "zipcode should be valid" do
    @address.zipcode = "111"
    assert_not @address.valid?
  end

  test "city should be present" do
    @address.city = ""
    assert_not @address.valid?
  end

  test "state should be present" do
    @address.state = ""
    assert_not @address.valid?
  end

end
