# frozen_string_literal: true

class HeadMusic::ScaleDegree
  include Comparable

  NAME_FOR_DIATONIC_DEGREE = [nil, 'tonic', 'supertonic', 'mediant', 'subdominant', 'dominant', 'submediant']

  attr_reader :key_signature, :spelling
  delegate :scale, to: :key_signature
  delegate :scale_type, to: :scale

  def initialize(key_signature, spelling)
    @key_signature = key_signature
    @spelling = HeadMusic::Spelling.get(spelling)
  end

  def degree
    scale.letter_name_cycle.index(spelling.letter_name.to_s) + 1
  end

  def sign
    sign_semitones = spelling.sign && spelling.sign.semitones || 0
    usual_sign_semitones = scale_degree_usual_spelling.sign && scale_degree_usual_spelling.sign.semitones || 0
    delta = sign_semitones - usual_sign_semitones
    HeadMusic::Sign.by(:semitones, delta) if delta != 0
  end

  def to_s
    "#{sign}#{degree}"
  end

  def <=>(other)
    if other.is_a?(HeadMusic::ScaleDegree)
      [degree, sign.semitones] <=> [other.degree, other.sign.semitones]
    else
      to_s <=> other.to_s
    end
  end

  def name_for_degree
    if scale_type.diatonic?
      NAME_FOR_DIATONIC_DEGREE[degree] ||
      (scale_type.intervals.last == 1 || sign == '#' ? 'leading tone' : 'subtonic')
    end
  end

  private

  def scale_degree_usual_spelling
    HeadMusic::Spelling.get(scale.spellings[degree - 1])
  end
end
