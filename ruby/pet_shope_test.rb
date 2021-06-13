require 'minitest/autorun'
require_relative 'pet_shop'


class PetShopTest < Minitest::Test
  def test_one_rat
    # skip
    assert_equal Order.new(['R']).boxes, ['B1']
  end

  def test_one_hedgehog
    # skip
    assert_equal Order.new(['H']).boxes, ['B1']
  end

  def test_one_mongoose
    # skip
    assert_equal Order.new(['M']).boxes, ['B2']
  end

  def test_one_snake
    # skip
    assert_equal Order.new(['S']).boxes, ['B3']
  end

  def test_rat_hedgehog_hedgehog
    # skip
    assert_equal Order.new(['R', 'H', 'H']).boxes, ['B3']
  end

  def test_snake_mongoose
    # skip
    assert_equal Order.new(['S', 'M']).boxes, ['B2', 'B3'].sort
  end

  def test_snake_hedgehog_rat_mongoose
    # skip
    assert_equal Order.new(['S', 'H', 'R', 'M']).boxes, ['B3', 'B3'].sort
  end

  def test_rat_hedgehog_snake
    # skip
    assert_equal Order.new(['R', 'H', 'S']).boxes, ['B1', 'B3'].sort
  end

  def test_disallow_other_aniomals
    # skip
    assert_raises(ArgumentError) { Order.new(['X', 'Y', 'Z']) }
  end
end
