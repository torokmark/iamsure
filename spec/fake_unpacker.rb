
class FakeUnpacker < Iamsure::Unpacker
  def unpack(arg)
    "#{ arg} unpacked"
  end
end