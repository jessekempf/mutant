module Mutant
  class Matcher
    class Method
      # Matcher for instance methods
      class Instance < self
        SUBJECT_CLASS = Subject::Method::Instance

        # Dispatching builder, detects adamantium case
        #
        # @param [Cache] cache
        # @param [Class, Module] scope
        # @param [UnboundMethod] method
        #
        # @return [Matcher::Method::Instance]
        #
        # @api private
        #
        def self.build(cache, scope, method)
          if scope.ancestors.include?(::Adamantium) and scope.memoized?(method.name)
            return Memoized.new(cache, scope, method)
          end
          super
        end

        # Return identification
        #
        # @return [String]
        #
        # @api private
        #
        def identification
          "#{scope.name}##{method_name}"
        end
        memoize :identification

        NAME_INDEX = 0

      private

        # Check if node is matched
        #
        # @param [Parser::AST::Node] node
        #
        # @return [true]
        #   returns true if node matches method
        #
        # @return [false]
        #   returns false if node NOT matches method
        #
        # @api private
        #
        def match?(node)
          location                  = node.location       || return
          expression                = location.expression || return
          expression.line           == source_line &&
          node.type                 == :def        &&
          node.children[NAME_INDEX] == method_name
        end

        # Matcher for memoized instance methods
        class Memoized < self
          SUBJECT_CLASS = Subject::Method::Instance::Memoized

        private

          # Return source location
          #
          # @return [Array]
          #
          # @api private
          #
          def source_location
            scope.original_instance_method(method.name).source_location
          end

        end # Memoized

      end # Instance
    end # Method
  end # Matcher
end # Mutant
