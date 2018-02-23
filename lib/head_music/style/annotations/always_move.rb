# frozen_string_literal: true

# Module for Annotations.
module HeadMusic::Style::Annotations; end

# A counterpoint guideline
class HeadMusic::Style::Annotations::AlwaysMove < HeadMusic::Style::Annotation
  MESSAGE = 'Always move to a different note.'

  def marks
    melodic_intervals.map.with_index do |interval, i|
      HeadMusic::Style::Mark.for_all(notes[i..i + 1]) if interval.shorthand == 'PU'
    end.compact
  end
end
