module Services
  class Base
    def self.call(attr)
      new.call(attr)
    end

    def call(attr)
      raise NotImplementedError
    end
  end
end
