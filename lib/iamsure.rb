require "iamsure/version"


module Iamsure
  class IamSure

    private_class_method :new

    def initialize(obj)
      @obj = obj
    end

    def self.of(obj)
      new(obj)
    end

    def not_nil(msg='')
      raise ArgumentError.new msg if obj.nil?
      self
    end

    def not_empty(msg='')
      raise ArgumentError.new msg unless obj.nil? || obj.empty?
      self
    end

    def exist(as=:file)
      raise ArgumentError.new 'Argument cannot be nil' if as.nil?
      raise ArgumentError.new "Argument should be Hash as 'as: :file' or 'as: :dir'" unless as.is_a?(Hash)

      if as.is_a?(Hash)
        if as.has_key?(:as) && as[:as] == :file
          raise ArgumentError.new "File (#{ @obj }) does not exist!" if not File.file?(@obj)
        elsif as.has_key?(:as) && as[:as] == :dir
          raise ArgumentError.new "Dir (#{ @obj }) does not exist!" if not File.directory?(@obj)
        else
          raise ArgumentError.new "Argument (#{ as }) is not valid!"
        end
      end
      self
    end

    def unpack(unpacker)
      raise ArgumentError.new "Argument cannot be nil!" if unpacker.nil?
      raise ArgumentError.new "Argument should be Unpacker!" unless unpacker.is_a?(Unpacker)

      @obj = unpacker.unpack(@obj)

      self
    end

    def get(initiator=nil)
      return @obj if initiator.nil?
      return Initiator.new(@obj) if initiator.is_a?(Initiator)
      raise ArgumentError.new "initiator should be empty or inherited from Initiator"
    end
  end
end
