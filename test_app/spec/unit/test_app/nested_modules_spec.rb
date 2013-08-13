require 'spec_helper'
require 'test_app/nested_modules'

describe TestApp::Nested do
  it 'does not explode' do
    TestApp::Nested.nested_module_member.should eq TestApp::Dummy.new
  end
end
