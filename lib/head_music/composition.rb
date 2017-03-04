class HeadMusic::Composition
  attr_reader :name, :key_signature, :meter, :measures, :voices

  def initialize(name:, key_signature: nil, meter: nil)
    ensure_attributes(name, key_signature, meter)
    add_measure
    add_voice
  end

  def add_measure
    add_measures(1)
  end

  def add_measures(number)
    @measures ||= []
    number.times do
      @measures << HeadMusic::Measure.new(self)
    end
  end

  def add_voice
    @voices ||= []
    @voices << HeadMusic::Voice.new(composition: self)
  end

  private

  def ensure_attributes(name, key_signature, meter)
    @name = name
    @key_signature = HeadMusic::KeySignature.get(key_signature) if key_signature
    @key_signature ||= HeadMusic::KeySignature.default
    @meter = HeadMusic::Meter.get(meter) if meter
    @meter ||= HeadMusic::Meter.default
  end
end