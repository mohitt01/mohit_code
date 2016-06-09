class GreatCircleDistance
  # This computes distance between two coordinates on earth using Great Circle
  # Distance model.
  # Refer wiki: https://en.wikipedia.org/wiki/Great-circle_distance
  
  RADIUS_OF_EARTH = 6371.freeze # km

  def initialize(coordinates1, coordinates2)
    @coordinates1 = coordinates1
    @coordinates2 = coordinates2
    validate_coordinates
  end

  def self.get_distance(coordinates1, coordinates2) # made this to support static usage
    self.new(coordinates1, coordinates2).get_distance
  end

  def get_distance
    (RADIUS_OF_EARTH * central_angle).round(2) # round value to 2 decimal places
  end

  private

  def validate_coordinates
    validate_coordinate(@coordinates1)
    validate_coordinate(@coordinates2)
  end

  def validate_coordinate(coordinate)
    lat = coordinate[0]
    long = coordinate[1]
    lat.abs <= 90 and long.abs <= 180 \
    or raise "Illegal coordinates: #{@coordinates}"
  end

  def radians(degrees)
    (Math::PI / 180) * degrees
  end

  def chord_length
    lat1, long1 = @coordinates1
    lat2, long2 = @coordinates2
    x = cos(lat2) * cos(long2) - cos(lat1) * cos(long1)
    y = cos(lat2) * sin(long2) - cos(lat1) * sin(long1)
    z = sin(lat2) - sin(lat1)
    sqrt(square(x) + square(y) + square(z))
  end

  def central_angle
    2 * arcsin(chord_length / 2)
  end

  def cos(degrees)
    Math.cos radians(degrees)
  end

  def sin(degrees)
    Math.sin radians(degrees)
  end

  def arcsin(number)
    Math.asin number
  end

  def square(number)
    number * number
  end

  def sqrt(number)
    Math.sqrt number
  end
end
