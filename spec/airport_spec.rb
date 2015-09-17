require 'airport'

describe Airport do

  let(:plane) { double :plane, land: true, take_off: true }

  before(:each) { allow(subject).to receive(:set_weather) { :Sunny } }
  describe 'ariving' do
    it 'instructs a plane to land' do
      expect(subject).to respond_to :land_plane
    end

    it 'receives a plane' do
      subject.land_plane(plane)
      expect(subject.planes).to_not be_empty
    end

    it "plane should land on arival" do
      plane = spy :plane
      subject.land_plane(plane)
      expect(plane).to have_received(:land)
    end
  end

  describe 'leaving' do
    it 'instructs a plane to take off' do
      expect(subject).to respond_to :leaving_plane
    end

    it 'releases a plane' do
      subject.land_plane(plane)
      subject.leaving_plane(plane)
      expect(subject.planes).to be_empty
    end

    it "plane should take off on leaving" do
      plane = spy :plane
      subject.land_plane(plane)
      subject.leaving_plane(plane)
      expect(plane).to have_received(:take_off)
    end

    it "shouldn't let out planes that aren't in the airport" do
      expect { subject.leaving_plane(plane) }.to raise_error "The plane is not at this airport"
    end

  end

  context 'traffic control' do
    context 'when airport is full' do
      it 'does not allow a plane to land' do
        subject.capacity.times {subject.land_plane(plane)}
        expect { subject.land_plane(plane) }.to raise_error "Cannot land, airport full"
      end 
    end

    context 'when weather conditions are stormy' do
      it 'does not allow a plane to take off' do
        subject.land_plane(plane)
        allow(subject).to receive(:set_weather) { :Stormy }
        expect { subject.leaving_plane(plane) }.to raise_error "Cannot take off, weather conditions too bad"
      end

      it 'does not allow a plane to land' do
        allow(subject).to receive(:set_weather) { :Stormy }
        expect { subject.land_plane(plane) }.to raise_error "Cannot land, weather conditions too bad"
      end 
    end
  end
  context 'capacity' do
    it 'is defaulted to 10 planes' do
      expect(subject.capacity).to eq 10
    end
    it 'can be custom on creation' do
      airport = Airport.new(11)
      expect(airport.capacity).to eq 11
    end
    it 'can be changed after creation' do
      subject.capacity = 5
      expect(subject.capacity).to eq 5
    end
  end
end