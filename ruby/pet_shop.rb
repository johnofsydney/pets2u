require 'pry'
class Order
  def initialize(animals)
    if animals.join('').match(/[^SMRH]/)
      throw ArgumentError.new('wrong animal!')
    end

    @animals = consolidate(animals)
  end

  def boxes
    required_boxes = []

    @animals[:snakes][:quantity].times {required_boxes.push('B3')}

    unallocated_area = (
      (@animals[:small_animals][:area]) + (@animals[:mongeese][:area])
      )

    while (unallocated_area > 0)
      if (unallocated_area > BOX_SIZES[:B2])
        required_boxes.push('B3')
        unallocated_area -= BOX_SIZES[:B3]
      elsif (unallocated_area >= BOX_SIZES[:B2])
        required_boxes.push('B2')
        unallocated_area -= BOX_SIZES[:B2]
      elsif (unallocated_area = BOX_SIZES[:B1])
        required_boxes.push('B1')
        unallocated_area -= BOX_SIZES[:B1]
      end
    end

    required_boxes.sort
  end
end

def consolidate(animals)
  zeroes = {H: 0, R: 0, M: 0, S: 0}

  animals = animals.reduce(zeroes) do |result, animal|
    result[animal.to_sym] = result[animal.to_sym] + 1
    result
  end

  snakes = animals[:S]
  mongeese = animals[:M]
  small_animals = animals[:H] + animals[:R]

  remaining_small_animals = small_animals > snakes ? small_animals - snakes : 0

  {
    snakes: {
      quantity: snakes, area: snakes * 1200
    },
    mongeese: {
      quantity: mongeese, area: mongeese * 800
    },
    small_animals: {
      quantity: remaining_small_animals,
      area: remaining_small_animals * 400
    }
  }
end

BOX_SIZES = {
  B1: 400,
  B2: 800,
  B3: 1600
}.freeze
