require 'test_helper'

class PadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pad = pads(:one)
  end

  test "should get index" do
    get pads_url
    assert_response :success
  end

  test "should get new" do
    get new_pad_url
    assert_response :success
  end

  test "should create pad" do
    assert_difference('Pad.count') do
      post pads_url, params: { pad: {  } }
    end

    assert_redirected_to pad_url(Pad.last)
  end

  test "should show pad" do
    get pad_url(@pad)
    assert_response :success
  end

  test "should get edit" do
    get edit_pad_url(@pad)
    assert_response :success
  end

  test "should update pad" do
    patch pad_url(@pad), params: { pad: {  } }
    assert_redirected_to pad_url(@pad)
  end

  test "should destroy pad" do
    assert_difference('Pad.count', -1) do
      delete pad_url(@pad)
    end

    assert_redirected_to pads_url
  end
end
