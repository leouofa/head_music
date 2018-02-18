class HeadMusic::Spelling
  MATCHER = /^\s*([A-G])(#{HeadMusic::Sign.matcher}?)(\-?\d+)?\s*$/i

  attr_reader :pitch_class
  attr_reader :letter_name
  attr_reader :sign

  delegate :number, to: :pitch_class, prefix: true
  delegate :to_i, to: :pitch_class_number
  delegate :cycle, to: :letter_name, prefix: true
  delegate :enharmonic?, to: :pitch_class

  def self.get(identifier)
    return identifier if identifier.is_a?(HeadMusic::Spelling)
    from_name(identifier) || from_number(identifier)
  end

  def self.match(string)
    string.to_s.match(MATCHER)
  end

  def self.from_name(name)
    if match(name)
      letter_name, sign_string, _octave = match(name).captures
      letter_name = HeadMusic::LetterName.get(letter_name)
      return nil unless letter_name
      sign = HeadMusic::Sign.get(sign_string)
      fetch_or_create(letter_name, sign)
    end
  end

  def self.from_number(number)
    return nil unless number == number.to_i
    pitch_class_number = number.to_i % 12
    letter_name = HeadMusic::LetterName.from_pitch_class(pitch_class_number)
    from_number_and_letter(number, letter_name)
  end

  def self.from_number_and_letter(number, letter_name)
    letter_name = HeadMusic::LetterName.get(letter_name)
    natural_letter_pitch_class = letter_name.pitch_class
    sign_interval = natural_letter_pitch_class.smallest_interval_to(HeadMusic::PitchClass.get(number))
    sign = HeadMusic::Sign.by(:semitones, sign_interval) if sign_interval != 0
    fetch_or_create(letter_name, sign)
  end

  def self.fetch_or_create(letter_name, sign)
    @spellings ||= {}
    hash_key = [letter_name, sign].join
    @spellings[hash_key] ||= new(letter_name, sign)
  end

  def initialize(letter_name, sign = nil)
    @letter_name = HeadMusic::LetterName.get(letter_name.to_s)
    @sign = HeadMusic::Sign.get(sign)
    sign_semitones = @sign ? @sign.semitones : 0
    @pitch_class = HeadMusic::PitchClass.get(letter_name.pitch_class + sign_semitones)
  end

  def name
    [letter_name, sign].join
  end

  def to_s
    name
  end

  def sharp?
    sign && sign == '#'
  end

  def flat?
    sign && sign == 'b'
  end

  def ==(value)
    other = HeadMusic::Spelling.get(value)
    to_s == other.to_s
  end

  def scale(scale_type_name = nil)
    HeadMusic::Scale.get(self, scale_type_name)
  end

  private_class_method :new
end
