# frozen_string_literal: true

class Point
  attr_accessor :x, :y

  # @param x [Int] x-axis coordinate for the point
  # @param y [Int] y-axis coordinate for the point
  # @return [Point] a {Point}
  def initialize(x, y)
    @x = x
    @y = y
  end
end

class Line # < Array
  attr_accessor :origin, :terminus

  attr_reader :horizontal, :vertical, :points

  # @param origin [Point]
  # @param terminus [Point]
  # @return [Line] a {Line}
  def initialize(origin, terminus)
    raise "Invalid element type #{origin.class}, expected Point" unless origin.is_a?(Point)
    raise "Invalid element type #{terminus.class}, expected Point" unless terminus.is_a?(Point)
    @origin = origin
    @terminus = terminus
    @horizontal = horizontal?(origin, terminus)
    @vertical = vertical?(origin, terminus)
    @points = fill_in_points(origin, terminus)
  end

  private

  def horizontal?(origin, terminus)
    origin.x == terminus.x
  end

  def vertical?(origin, terminus)
    origin.y == terminus.y
  end

  def fill_in_points(origin, terminus)
    points = []

    if self.horizontal
      ([origin.y, terminus.y].min..[origin.y, terminus.y].max).step(1) do |i|
        # binding.pry
        points << Point.new(origin.x, i)
      end
    elsif self.vertical
      ([origin.x, terminus.x].min..[origin.x, terminus.x].max).step(1) do |i|
        # binding.pry
        points << Point.new(i, origin.y)
      end
    else
      xstep = origin.x > terminus.x ? -1 : 1
      ystep = origin.y > terminus.y ? -1 : 1
      xpoint = origin.x
      ypoint = origin.y
      while xpoint != terminus.x
        points << Point.new(xpoint, ypoint)
        xpoint += xstep
        ypoint += ystep
      end
      points << Point.new(terminus.x, terminus.y)

    end

    points
  end
end
