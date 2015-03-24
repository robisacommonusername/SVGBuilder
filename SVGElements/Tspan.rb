require_relative 'SVGObject'
require_relative '../Mixins/StylableMixin'
module SVG
	class Tspan < SVGObject
		include StylableMixin
		
		def initialize(contents='', x=nil, y=nil, do_escape=true)
			super()
			stylable_init
			
			@name = 'tspan'
			@contents = contents
			@escape = do_escape
			@attributes[:x] = x
			@attributes[:y] = y
			
			yield self if block_given?
			return self
		end
		attr_accessor :contents
		
		def to_xml
			content_str = @escape ? (escape_xml @contents) : @contents
			"<tspan #{attributes_string}>#{content_str}</tspan>"
		end
		
	end
end
