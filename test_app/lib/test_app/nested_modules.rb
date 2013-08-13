module TestApp
  class Dummy
    def ==(rhs)
      rhs.is_a?(Dummy)
    end
  end
end

module TestApp::Nested
  def self.nested_module_member
    TestApp::Dummy.new
  end
end
