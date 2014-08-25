module Quantity
  module Parseable
    extend ActiveSupport::Concern

    def update(attributes)
      if attributes.is_a?(String)
        attributes = parse(attributes)
      end
      super
    end

    module ClassMethods
      def new(*args, &block)
        if args.first.is_a?(String)
          super(parse(args.first), &block)
        else
          super
        end
      end

      def create(attributes = nil, &block)
        if attributes.is_a?(String)
          attributes = parse(attributes)
        end
        super
      end

      def parse(string)
        {}
      end
    end
  end
end
