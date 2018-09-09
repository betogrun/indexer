module Parser
  module Tag
    class Header < Base
      def content
        tag.text
      end
    end
  end
end
