require 'test_helper'

class StoreTest < ActiveSupport::TestCase
  def setup
    @store = Store.new(public_name: "Giant", legal_name: "Giant Bicyle",
                       cnpj: "05393625000184", area_code: "10")
  end

  test "should be valid" do
    assert @store.valid?
  end

  test "public_name should be present" do
    @store.public_name = ""
    assert @store.invalid?
  end

  test "legal_name should be present" do
    @store.legal_name = ""
    assert @store.invalid?
  end

  test "cnpj should be present" do
    @store.cnpj = ""
    assert @store.invalid?
  end

  test "cnpj should be valid" do
    @store.cnpj = "1234567890123"
    assert @store.invalid?
  end

  test "area_code should be present" do
    @store.area_code = ""
    assert @store.invalid?
  end

  test "area_code should be valid" do
    @store.area_code = "xy"
    assert @store.invalid?
    @store.area_code = "123"
    assert @store.invalid?
  end
end
