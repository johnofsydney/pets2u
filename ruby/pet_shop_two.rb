# Order class
class Order
  BOXES = {
    100 => 'B0',
    400 => 'B1',
    800 => 'B2',
    1600 => 'B3'
  }.freeze

  def initialize(animals)
    throw ArgumentError.new('wrong animal!') unless valid?(animals)

    @animals = animals
                .map{ |animal| Animal.new(animal) }
                .sort_by(&:area)
  end

  def boxes # rubocop:disable Metrics/MethodLength
    required_boxes = []
    @unallocated_space = []

    # while there are remaining animals, keep packing
    while @animals.length.positive?
      # take the largest animal from the list of remaining animals
      animal = @animals.pop
      if space_exists?(animal)
        use_existing_space(animal)
      else
        # we need at least one more box
        # what is the smallest box required
        box = calculate_smallest_box(animal)

        # add that box to the list of required boxes
        required_boxes.push(box[:box_type])

        # add the space inthe box to the array, maybe we can fill it later
        @unallocated_space.push(box[:remaining_space])
      end
    end

    required_boxes.sort
  end

  private

  def valid?(animals)
    !animals.join('').match(/[^SMRHC]/)
  end

  def calculate_smallest_box(animal)
    unpacked_animals_area = @animals
                            .dup
                            .push(animal)
                            .map{ |a| a.area }
                            .sum

    max_box_size = BOXES.keys.max

    # special case when the room required is large than
    # the largest abailable box
    if unpacked_animals_area >= max_box_size
      return {
        box_type: BOXES[max_box_size],
        remaining_space: (max_box_size - animal.area)
      }
    end

    # otherwise find the smales box that will fit all animals
    box_size = BOXES
               .keys
               .filter { |b| b >= unpacked_animals_area }
               .min

    {
      box_type: BOXES[box_size],
      remaining_space: (box_size - animal.area)
    }
  end

  def space_exists?(animal)
    @unallocated_space
      .filter{ |space| space >= animal.area}
      .length
      .positive?
  end

  def use_existing_space(animal)
    @unallocated_space = @unallocated_space.sort
    space = @unallocated_space.pop
    space -= animal.area
    @unallocated_space.push(space)
  end
end

# Animal class
class Animal
  attr_reader :area

  def initialize(type)
    @area = case type
            when 'S'
              1200
            when 'M'
              800
            when 'H'
              400
            when 'R'
              400
            when 'C'
              50
            end
  end
end
