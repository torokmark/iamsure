RSpec.describe Iamsure do
  describe '.of' do
    it 'creates a new object of Iamsure'
  end

  describe '#get' do

  end

  describe '#not_nil' do
    context "when object is nil" do
      it 'raises ArgumentError'
    end

    context 'when object is instance' do
      it 'returns self of Iamsure'
    end
  end

  describe 'not_empty' do
    context 'when object is nil' do
      it 'raises ArgumentError'
    end

    context 'when object is empty' do
      it 'raises ArgumentError'
    end

    context 'when object is instance' do
      it 'returns the object'
    end
  end

  describe 'exist' do
    context 'when argument is nil' do
      it 'raises ArgumentError'
    end

    context 'when argument is no Hash' do
      it 'raises ArgumentError'
    end
  end

  describe 'unpack'
end
