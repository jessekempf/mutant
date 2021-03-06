module Mutant
  class Mutator
    class Node
      class Literal

        # Abstract literal range mutator
        class Range < self
          include AbstractType

          MAP = {
            :irange => :erange,
            :erange => :irange
          }.freeze

          children :start, :_end

          handle(*MAP.keys)

        private

          # Emit mutants
          #
          # @return [undefined]
          #
          # @api private
          #
          def dispatch
            emit_nil
            emit_inverse
            emit_start_mutations
            emit_end_mutations
          end

          # Return inverse node
          #
          # @return [Parser::AST::Node]
          #
          # @api private
          #
          def emit_inverse
            emit(s(MAP.fetch(node.type), *children))
          end

          # Emit range start mutations
          #
          # @return [undefined]
          #
          # @api private
          #
          def emit_end_mutations
            #emit_self(negative_infinity, finish)
            emit_self(NAN, _end)
          end

          # Emit start mutations
          #
          # @return [undefined]
          #
          # @api private
          #
          def emit_start_mutations
            emit_self(start, INFINITY)
            emit_self(start, NAN)
          end

        end # Range
      end # Literal
    end # Node
  end # Mutator
end # Mutant
