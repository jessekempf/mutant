module Mutant
  class Runner
    # Subject specific runner
    class Subject < self
      include Concord::Public.new(:config, :subject)

      register Mutant::Subject

      # Initialize object
      #
      # @param [Config] config
      # @param [Subject] subject
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(config, subject)
        @subject = subject
        super(config)
      end

      # Return mutation runners
      #
      # @return [Enumerable<Runner::Mutation>]
      #
      # @api private
      #
      attr_reader :mutations

      # Return failed mutations
      #
      # @return [Enumerable<Mutation>]
      #
      # @api private
      #
      def failed_mutations
        mutations.reject(&:success?)
      end
      memoize :failed_mutations

      # Test if subject was processed successful
      #
      # @return [true]
      #   if successful
      #
      # @return [false]
      #   otherwise
      #
      # @api private
      #
      def success?
        failed_mutations.empty?
      end

    private

      # Perform operation
      #
      # @return [undefined]
      #
      # @api private
      #
      def run
        subject = self.subject
        report(subject)
        @mutations = dispatch(subject.mutations)
        report(self)
      end

    end # Subject
  end # Runner
end # Mutant
