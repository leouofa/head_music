module HeadMusic::Style::Annotations
end

class HeadMusic::Style::Annotations::UpToThirteenNotes < HeadMusic::Style::Annotation
  MAXIMUM_NOTES = 13

  def message
    'Write up to thirteen notes.'
  end

  def marks
    if overage > 0
      Style::Mark.for_all(notes[13..-1])
    end
  end

  private

  def overage
    [notes.length - MAXIMUM_NOTES, 0].max
  end
end
