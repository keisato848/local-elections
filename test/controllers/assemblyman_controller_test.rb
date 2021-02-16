require 'test_helper'

class AssemblymanControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get assemblyman_index_url
    assert_response :success
  end
end
