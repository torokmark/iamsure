
class FakeInitiator < Iamsure::Initiator
  def init(args)
    args[:a] = :b
    args
  end
end