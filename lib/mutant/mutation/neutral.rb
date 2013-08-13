# encoding: utf-8

module Mutant
  class Mutation
    # Neutral mutation
    class Neutral < self

      SYMBOL = 'neutral'

      # Noop mutation, special case of neutral
      class Noop < self

        SYMBOL = 'noop'

        # Indicate if a killer should treat a kill as problematic
        #
        # @return [true] Killing noop mutants is a serious problem. Failures
        #   in noop may indicate a broken test suite, but they can also be an
        #   indication  mutant has altered the runtime environment in a subtle
        #   way and tickled an odd bug
        #
        # @api private
        #
        def should_survive?
          true
        end

      end # Noop

      # Null mutation, mutation that doesn't alter the code being run at all.
      # The difference between a null and a noop is that noop executes
      # +unparse(parse(code))+, and null executes +code+.
      class Null < self
        SYMBOL = 'null'

        # Indicate if a killer should treat a kill as problematic
        #
        # @return [true] If the killer kills the original code the test suite
        #   is broken
        def should_survive?
          true
        end

        # Dummy-out mutated node insert
        def insert
          self
        end
      end # Null

      # Return identification
      #
      # @return [String]
      #
      # @api private
      #
      def identification
        "#{self.class::SYMBOL}:#{super}"
      end
      memoize :identification

      # Test if killer is successful
      #
      # @param [Killer] killer
      #
      # @return [true]
      #   if killer did NOT killed mutation
      #
      # @return [false]
      #   otherwise
      #
      # @api private
      #
      def success?(killer)
        !killer.killed?
      end

      # Indicate if a killer should treat a kill as problematic
      #
      # @return [true] Neutral mutants must die
      #
      # @api private
      #
      def should_survive?
        false
      end

    end # Neutral
  end # Mutation
end # Mutant
