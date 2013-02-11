require 'test_helper'

class WeightMeasurementsControllerTest < ActionController::TestCase
  setup do
    @weight_measurement = weight_measurements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weight_measurements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weight_measurement" do
    assert_difference('WeightMeasurement.count') do
      post :create, weight_measurement: { unit: @weight_measurement.unit, value: @weight_measurement.value }
    end

    assert_redirected_to weight_measurement_path(assigns(:weight_measurement))
  end

  test "should show weight_measurement" do
    get :show, id: @weight_measurement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @weight_measurement
    assert_response :success
  end

  test "should update weight_measurement" do
    put :update, id: @weight_measurement, weight_measurement: { unit: @weight_measurement.unit, value: @weight_measurement.value }
    assert_redirected_to weight_measurement_path(assigns(:weight_measurement))
  end

  test "should destroy weight_measurement" do
    assert_difference('WeightMeasurement.count', -1) do
      delete :destroy, id: @weight_measurement
    end

    assert_redirected_to weight_measurements_path
  end
end
