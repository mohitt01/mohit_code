class NearbyFriends
  # This class takes with a file with json-encoded friends
  # with coordinate data and should find friends within a
  # desired distance. It uses the GreatCircleDistance class
  
  require 'great_circle_distance'

  OUR_COORDINATES = [12.9611159, 77.6362214].freeze

  def initialize(distance, path_to_file)
    @friends_data = get_friends_from_file(path_to_file)
    @within_distance = distance
    @gcd = GreatCircleDistance
  end

  def get_friends_within_distance
    filter_friends_by_distance
    sort_by_user_id.collect { |f| filter_name_and_userid f }
  end

  private

  def filter_name_and_userid(friend)
    friend.select { |k, _v| %w[user_id name].include? k }
  end

  def sort_by_user_id
    @friends_data.sort_by! { |friend| friend['user_id'] }
  end

  def filter_friends_by_distance
    @friends_data.delete_if { |f| get_distance_from_friend(f) > 100 }
  end

  def get_distance_from_friend(friend)
    coordinates = [friend['latitude'].to_f, friend['longitude'].to_f]
    @gcd.get_distance(coordinates, OUR_COORDINATES)
  end

  def get_friends_from_file(path)
    begin
      file = File.readlines(path)
    rescue
      raise 'File not found!'
    end
    file.collect { |line| parse_json_to_hash(line) }
  end

  def parse_json_to_hash(json)
    require 'json'
    begin
      JSON.parse(json)
    rescue
      raise 'Unable to parse json from file'
    end
  end
end
