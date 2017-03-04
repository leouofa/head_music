module HeadMusic
  module Style
    class Analysis
      attr_reader :rule, :subject

      def initialize(rule, subject)
        @rule = rule
        @subject = subject
      end

      # returns a score between 0 and 1
      def score
        rule.fitness(subject)
      end
    end
  end
end