require 'fake_initiator'
require 'fake_unpacker'

RSpec.describe Iamsure do
  describe '.of' do
    it 'creates a new object of Iamsure' do
      expect(Iamsure::IamSure.of('something')).not_to be_nil
    end
  end

  describe '#get' do
    context 'when initiator is nil' do
      subject { Iamsure::IamSure.of({}) }
      it 'returns the initiated object' do
        expect( subject.get ).to eq({})
      end
    end

    context 'when initiator is not nil' do
      context 'and valid initiator' do
        subject { Iamsure::IamSure.of({}) }
        let (:initiator) { FakeInitiator.new }
        
        it 'returns the value transformed by initiator' do
          expect( subject.get(initiator) ).to eq({a: :b})
        end
      end

      context 'and not valid initiator' do
        subject { Iamsure::IamSure.of(nil) }
        it 'raises ArgumentError' do
          expect { subject.get('not initiator') }.to raise_error(ArgumentError)          
        end
      end
    end

  end

  describe '#not_nil' do
    context "when object is nil" do
      subject { Iamsure::IamSure.of(nil) }
      it 'raises ArgumentError' do
        expect { subject.not_nil('message') }.to raise_error(ArgumentError)
      end
    end

    context 'when object is instance' do
      subject { Iamsure::IamSure.of({}) }
      it 'returns self of Iamsure' do
        expect(subject.not_nil).to eq(subject)
      end
    end
  end

  describe '#not_empty' do
    context 'when object is nil' do
      subject { Iamsure::IamSure.of(nil) }
      it 'raises ArgumentError' do
        expect { subject.not_empty }.to raise_error(ArgumentError)
      end
    end

    context 'when object is empty' do
      subject { Iamsure::IamSure.of('') }
      it 'raises ArgumentError' do 
        expect { subject.not_empty }.to raise_error(ArgumentError)
      end
    end

    context 'when object is instance' do
      subject { Iamsure::IamSure.of(a: :b) }
      it 'returns the object' do
        expect(subject.not_empty).to eq(subject)
      end
    end
  end

  describe '#exist' do
    context 'when argument is nil' do      
      subject { Iamsure::IamSure.of(nil) }
      it 'raises ArgumentError' do
        expect { subject.exist(nil) }.to raise_error(ArgumentError)
      end
    end

    context 'when argument is no Hash' do
      subject { Iamsure::IamSure.of(nil) }
      it 'raises ArgumentError' do
        expect { subject.exist('') }.to raise_error(ArgumentError)
      end
    end

    context 'when argument is Hash' do
      subject { Iamsure::IamSure.of(nil) }
      context 'and not containing valid key' do
        it 'raises ArgumentError' do
          expect { subject.exist(a: :b) }.to raise_error(ArgumentError)
        end
      end

      context 'and containing valid key' do
        context 'and not valid value' do
          it 'raises ArgumentError' do
            expect { subject.exist(as: :not_valid) }.to raise_error(ArgumentError)
          end
        end

        context 'and valid value' do
          context 'and initiale value is' do
            context 'existing file' do
              subject { Iamsure::IamSure.of('./spec/iamsure_spec.rb') }
              it 'returns the the object' do
                expect( subject.exist(as: :file) ).to eq(subject)
              end
            end
            context 'existing dir' do
              subject { Iamsure::IamSure.of('./') }
              it 'returns the the object' do
                expect( subject.exist(as: :dir) ).to eq(subject)
              end
            end
          end

          context 'and initiale value is not' do
            context 'existing file' do
              subject { Iamsure::IamSure.of('./path/somewhere.rb') }
              it 'raises error' do
                expect { subject.exist(as: :file) }.to raise_error(ArgumentError)
              end
            end
            context 'existing dir' do
              subject { Iamsure::IamSure.of('./path/somewhere') }
              it 'raises error' do
                expect { subject.exist(as: :dir) }.to raise_error(ArgumentError)
              end
            end
          end
        end
      end
    end
  end

  describe '#unpack' do
    context 'when unpacker is nil' do
      subject { Iamsure::IamSure.of({}) }
      it 'raises ArgumentError' do
        expect { subject.unpack(nil) }.to raise_error(ArgumentError)
      end
    end

    context 'when unpacker is not an Unpacker' do
      subject { Iamsure::IamSure.of({}) }
      let (:unpacker) { 'some string' }

      it 'raises ArgumentError' do
        expect { subject.unpack(unpacker) }.to raise_error(ArgumentError)
      end
    end

    context 'when unpacker is an Unpacker' do
      let (:init_value) { {} }
      let (:unpacker) { FakeUnpacker.new }
      
      subject { Iamsure::IamSure.of(init_value) }

      it 'returns unpacked value' do
        expect( subject.unpack(unpacker).get ).to eq("#{ init_value } unpacked")
      end
    end
  end
end
