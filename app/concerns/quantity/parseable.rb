module Quantity
  module Parseable
    extend ActiveSupport::Concern

    def initialize(attributes)
      if attributes.is_a?(String)
        attributes = parse(attributes)
      end
      super(attributes)
    end

    def update(attributes)
      if attributes.is_a?(String)
        attributes = parse(attributes)
      end
      super(attributes)
    end

    module ClassMethods
      def create(attributes = nil, &block)
        if attributes.is_a?(String)
          attributes = parse(attributes)
        end
        super(attributes, &block)
      end

      def parse(string)
        {}
      end
    end
  end
end
