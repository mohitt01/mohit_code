require 'nearby_friends'

TEST_FILE = 'friends_test.json'.freeze

describe 'NearbyFriends' do
  describe '#get_friends_within_distance' do
    context 'given TEST_FILE with 1 friend with same location as ours' do
      it 'returns the user_id and name of that friend' do
        require 'json'
        friend = { 'user_id' => 1, 'name' => 'test', 'latitude' => '12.9611159', 'longitude' => '77.6362214' }
        File.open(TEST_FILE, 'w') do |f|
          f.puts friend.to_json
        end
        nearby_friends = NearbyFriends.new(100, TEST_FILE)
        File.delete(TEST_FILE)
        expect(nearby_friends.get_friends_within_distance).to eq [{ 'user_id' => 1, 'name' => 'test' }]
      end
    end
  end
  describe '#get_friends_within_distance' do
    context 'given TEST_FILE with 1 friend with location of north pole' do
      it 'returns a blank array ' do
        require 'json'
        friend = { 'user_id' => 1, 'name' => 'test', 'latitude' => '90', 'longitude' => '77.6362214' }
        File.open(TEST_FILE, 'w') do |f|
          f.puts friend.to_json
        end
        nearby_friends = NearbyFriends.new(100, TEST_FILE)
        File.delete(TEST_FILE)
        expect(nearby_friends.get_friends_within_distance).to eq []
      end
    end
  end
  describe '#get_friends_within_distance' do
    context 'given friends.json with 1 friend per line and a distance of 100' do
      it 'returns names and user_ids of friends within 100km, sorted by user_id' do
        require 'json'
        friend1 = { 'user_id' => 45, 'name' => 'test', 'latitude' => '12.9611159', 'longitude' => '77.6362214' }
        friend2 = { 'user_id' => 12, 'name' => 'test', 'latitude' => '12.9611159', 'longitude' => '77.6362214' }
        friend3 = { 'user_id' => 99, 'name' => 'test', 'latitude' => '12.9611159', 'longitude' => '77.6362214' }
        File.open(TEST_FILE, 'w') do |f|
          f.puts friend1.to_json
          f.puts friend2.to_json
          f.puts friend3.to_json
        end
        nearby_friends = NearbyFriends.new(100, TEST_FILE)
        File.delete(TEST_FILE)
        expect(nearby_friends.get_friends_within_distance).to eq [{ 'user_id' => 12, 'name' => 'test' },
                                                                  { 'user_id' => 45, 'name' => 'test' },
                                                                  { 'user_id' => 99, 'name' => 'test' }]
      end
    end
  end
end

File.delete(TEST_FILE) rescue nil
