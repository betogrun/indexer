module Parser
  module Tag
    class Link < Base
      def content
        tag[:href]
      end
    end
  end
end
