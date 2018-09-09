require_relative 'base'
require_relative 'header'
require_relative 'link'

module Parser
  module Tag
    class Factory < Base
      def fabricate
        if ['h1', 'h2', 'h3'].include?(tag.name)
          Header.new(tag)
        elsif tag.name == 'a'
          Link.new(tag)
        end
      end
    end
  end
end
