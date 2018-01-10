require 'test_helper'

class BeneficesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @benefice = benefices(:one)
  end

  test "should get index" do
    get benefices_url
    assert_response :success
  end

  test "should get new" do
    get new_benefice_url
    assert_response :success
  end

  test "should create benefice" do
    assert_difference('Benefice.count') do
      post benefices_url, params: { benefice: { estado: @benefice.estado, fecha_vencimiento: @benefice.fecha_vencimiento } }
    end

    assert_redirected_to benefice_url(Benefice.last)
  end

  test "should show benefice" do
    get benefice_url(@benefice)
    assert_response :success
  end

  test "should get edit" do
    get edit_benefice_url(@benefice)
    assert_response :success
  end

  test "should update benefice" do
    patch benefice_url(@benefice), params: { benefice: { estado: @benefice.estado, fecha_vencimiento: @benefice.fecha_vencimiento } }
    assert_redirected_to benefice_url(@benefice)
  end

  test "should destroy benefice" do
    assert_difference('Benefice.count', -1) do
      delete benefice_url(@benefice)
    end

    assert_redirected_to benefices_url
  end
end
