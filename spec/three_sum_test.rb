require 'three_sum'

describe ThreeSum do
  describe '#get_triplet_with_sum' do
    context 'given sum 6 and numbers [5,3,6,1,7,2]' do
      it 'returns triplet [1,2,3]' do
        three_sum = ThreeSum.new(6, [-5, 3, 6, 1, 7, 2])
        triplet = three_sum.get_triplet_with_sum
        expect(triplet.sort).to eq [1, 2, 3]
      end
    end

    context 'given sum 10 and a array of floats' do
      it 'returns triplet with sum 10' do
        three_sum = ThreeSum.new(10, [1.1, 4.2, 9.9, 8.4, 3.8, 3.3, 4.1, 2.6])
        triplet = three_sum.get_triplet_with_sum
        expect(triplet.sort).to eq [2.6, 3.3, 4.1]
      end
    end

    context 'given a sum and a array smaller than 3' do
      it 'raises a RuntimeError' do
        three_sum = ThreeSum.new(4, [3, 1])
        expect { three_sum.get_triplet_with_sum }.to raise_error RuntimeError
      end
    end

    context 'given a sum and a array with no triplet with sum' do
      it 'raises a RuntimeError' do
        three_sum = ThreeSum.new(0, [1, 2, 3])
        expect { three_sum.get_triplet_with_sum }.to raise_error RuntimeError
      end
    end
  end
end
