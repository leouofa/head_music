module HeadMusic
  module Style
    class Analysis
      attr_reader :ruleset, :subject, :annotations

      def initialize(ruleset, subject)
        @ruleset = ruleset
        @subject = subject
      end

      def messages
        annotations.reject(&:perfect?).map(&:message)
      end

      def annotations
        @annotations ||= @ruleset.analyze(subject)
      end

      def fitness
        return 1.0 if annotations.length == 0
        fitness_scores.inject(:+).to_f / fitness_scores.length
      end

      private

      def fitness_scores
        annotations.map(&:fitness)
      end
    end
  end
end
