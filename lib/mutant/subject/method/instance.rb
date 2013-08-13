# encoding: utf-8

module Mutant
  class Subject
    class Method
      # Instance method subjects
      class Instance < self

        NAME_INDEX = 0
        SYMBOL = '#'.freeze

        # Test if method is public
        #
        # @return [true]
        #   if method is public
        #
        # @return [false]
        #   otherwise
        #
        # @api private
        #
        def public?
          scope.public_method_defined?(name)
        end
        memoize :public?

      private

        # Mutator for memoized instance methods
        class Memoized < self
          include NodeHelpers

        private

          # Return mutations
          #
          # @param [#<<] emitter
          #
          # @return [undefined]
          #
          # @api private
          #
          def generate_mutations(emitter)
            noop_mutations.each { |noop| emitter << noop }
            Mutator.each(node) do |mutant|
              emitter << Mutation::Evil.new(self, memoizer_node(mutant))
            end
          end

          # Return neutral mutations
          #
          # @return [Enumerable<Mutation::Neutral>]
          #
          # @api private
          #
          def noop_mutations
            [Mutation::Neutral::Null, Mutation::Neutral::Noop].map do |noop|
              noop.new(self, memoizer_node(node))
            end
          end

          # Return memoizer node for mutant
          #
          # @param [Parser::AST::Node] mutant
          #
          # @return [Parser::AST::Node]
          #
          # @api private
          #
          def memoizer_node(mutant)
            s(:begin, mutant, s(:send, nil, :memoize, s(:args, s(:sym, name))))
          end

        end # Memoized
      end # Instance
    end # Method
  end # Subject
end # Mutant
