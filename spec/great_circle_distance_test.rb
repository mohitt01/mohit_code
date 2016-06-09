require 'great_circle_distance'

describe 'GreatCircleDistance' do
  describe '#get_distance' do
    context 'given two coordinates [35.674520, 76.845245] and [8.06890, 77.55230]' do
      it 'returns ' do
        gcd = GreatCircleDistance.new([35.674520, 76.845245], [8.06890, 77.55230])
        distance = gcd.get_distance
        expect(distance.round(0)).to eq 3070 # Kashmir to Kanyakumari
      end
    end

    context 'given bad coordinates' do
      it 'raises RuntimeError' do
        gcd = GreatCircleDistance
        expect { p gcd.get_distance([91, 0], [0, 0]) }.to raise_error RuntimeError
      end
    end

    context 'given coordinates on the north pole' do
      it 'returns zero as distance' do
        gcd = GreatCircleDistance
        expect(gcd.get_distance([90, 0], [90, 90])).to eq 0
      end
    end
  end
end
