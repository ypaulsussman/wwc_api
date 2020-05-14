require 'test_helper'

class StudySearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get study_searches_create_url
    assert_response :success
  end

  test "should get autocomplete" do
    get study_searches_autocomplete_url
    assert_response :success
  end

end
