module Parser
  module Tag
    class Base
      attr_reader :tag

      def initialize(tag)
        @tag = tag
      end

      def extract
        {
          name: tag.name,
          content: content
        }
      end

      def content
        raise NotImplementedError
      end
    end
  end
end
