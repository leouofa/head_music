module HeadMusic::Style::Annotations
end

class HeadMusic::Style::Annotations::StartOnTonic < HeadMusic::Style::Annotation
  MESSAGE = 'Start on the tonic.'

  def marks
    if first_note && !starts_on_tonic?
      HeadMusic::Style::Mark.for(first_note)
    end
  end
end
