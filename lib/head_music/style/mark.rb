class HeadMusic::Style::Mark
  attr_reader :start_position, :end_position, :placements, :fitness

  def self.for(placement, fitness: nil)
    new(placement.position, placement.next_position, placements: [placement], fitness: fitness)
  end

  def self.for_all(placements, fitness: nil)
    placements = [placements].flatten.compact
    return [] if placements.empty?
    start_position = placements.map { |placement| placement.position }.sort.first
    end_position = placements.map { |placement| placement.next_position }.sort.last
    new(start_position, end_position, placements: placements, fitness: fitness)
  end

  def self.for_each(placements, fitness: nil)
    placements = [placements].flatten
    placements.map { |placement| new(placement.position, placement.next_position, placements: placement, fitness: fitness) }
  end

  def initialize(start_position, end_position, placements: [], fitness: nil)
    @start_position = start_position
    @end_position = end_position
    @placements = [placements].flatten.compact
    @fitness = fitness || HeadMusic::PENALTY_FACTOR
  end

  def code
    [start_position, end_position].join(' to ')
  end

  def to_s
    code
  end
end
