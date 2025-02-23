require "test_helper"

class ColumnControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get column_new_url
    assert_response :success
  end

  test "should get index" do
    get column_index_url
    assert_response :success
  end

  test "should get show" do
    get column_show_url
    assert_response :success
  end

  test "should get edit" do
    get column_edit_url
    assert_response :success
  end
end
