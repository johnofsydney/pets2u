require 'minitest/autorun'
require_relative 'pet_shop_two'


class PetShopTest < Minitest::Test
  def test_one_rat
    assert_equal ['B1'], Order.new(['R']).boxes
  end

  def test_one_hedgehog
    assert_equal ['B1'], Order.new(['H']).boxes
  end

  def test_one_mongoose
    assert_equal ['B2'], Order.new(['M']).boxes
  end

  def test_one_snake
    assert_equal ['B3'], Order.new(['S']).boxes
  end

  def test_rat_hedgehog_hedgehog
    assert_equal ['B3'], Order.new(['R', 'H', 'H']).boxes
  end

  def test_snake_mongoose
    assert_equal ['B2', 'B3'].sort, Order.new(['S', 'M']).boxes
  end

  def test_snake_hedgehog_rat_mongoose
    assert_equal ['B3', 'B3'].sort, Order.new(['S', 'H', 'R', 'M']).boxes
  end

  def test_rat_hedgehog_snake
    assert_equal  ['B1', 'B3'].sort, Order.new(['R', 'H', 'S']).boxes
  end

  def test_disallow_other_aniomals
    assert_raises(ArgumentError) { Order.new(['X', 'Y', 'Z']) }
  end

  # extra tests

  def test_twenty_hedgehogs
    hedgehogs = []
    20.times{ hedgehogs.push('H') }
    assert_equal  ['B3', 'B3', 'B3', 'B3', 'B3'].sort, Order.new(hedgehogs).boxes
  end

  def test_cricket
    assert_equal  ['B0'].sort, Order.new(['C']).boxes
  end

  def test_two_crickets
    assert_equal  ['B0'].sort, Order.new(['C', 'C']).boxes
  end

  def test_three_crickets
    assert_equal  ['B1'].sort, Order.new(['C', 'C', 'C']).boxes
  end
end
