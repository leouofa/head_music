class HeadMusic::KeySignature
  attr_reader :tonic_spelling
  attr_reader :scale_type
  attr_reader :scale

  SHARPS = %w{F# C# G# D# A# E# B#}
  FLATS = %w{Bb Eb Ab Db Gb Cb Fb}

  def self.default
    @default ||= new('C', :major)
  end

  def self.get(identifier)
    return identifier if identifier.is_a?(HeadMusic::KeySignature)
    @key_signatures ||= {}
    tonic_spelling, scale_type_name = identifier.strip.split(/\s/)
    hash_key = HeadMusic::Utilities::HashKey.for(identifier.gsub(/#/, 'sharp').gsub(/b/, 'flat'))
    @key_signatures[hash_key] ||= new(tonic_spelling, scale_type_name)
  end

  delegate :pitch_class, to: :tonic_spelling, prefix: :tonic
  delegate :to_s, to: :name
  delegate :pitches, to: :scale

  def initialize(tonic_spelling, scale_type = nil)
    @tonic_spelling = HeadMusic::Spelling.get(tonic_spelling)
    @scale_type = HeadMusic::ScaleType.get(scale_type) if scale_type
    @scale_type ||= HeadMusic::ScaleType.default
    @scale_type = @scale_type.parent || @scale_type
    @scale = HeadMusic::Scale.get(@tonic_spelling, @scale_type)
  end

  def spellings
    pitches.map(&:spelling).uniq
  end

  def sharps
    spellings.select(&:sharp?).sort_by { |sharp| SHARPS.index(sharp.to_s) }
  end

  def flats
    spellings.select(&:flat?).sort_by { |flat| FLATS.index(flat.to_s) }
  end

  def num_sharps
    sharps.length
  end

  def num_flats
    flats.length
  end

  def sharps_or_flats
    flats.length > 0 ? flats : sharps
  end

  def name
    [tonic_spelling.to_s, scale_type.to_s].join(' ')
  end

  def ==(other)
    self.sharps_or_flats == self.class.get(other).sharps_or_flats
  end
end
