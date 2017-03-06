module HeadMusic::Style::Rules
end

class HeadMusic::Style::Rules::Diatonic < HeadMusic::Style::Rule
  def self.analyze(voice)
    marks = marks(voice)
    fitness = HeadMusic::GOLDEN_RATIO_INVERSE**marks.length
    message = "Use only notes in the key signature." if fitness < 1
    HeadMusic::Style::Annotation.new(subject: voice, fitness: fitness, marks: marks, message: message)
  end

  def self.marks(voice)
    HeadMusic::Style::Mark.for_each(voice.notes_not_in_key)
  end
end
