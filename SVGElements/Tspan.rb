require_relative 'SVGObject'
require_relative '../Mixins/StylableMixin'
class Tspan < SVGObject
	include StylableMixin
	
	def initialize(contents, do_escape=true)
		super
		stylable_init
		
		@name = 'tspan'
		@contents = contents
		@escape = do_escape
	end
	
	def to_xml
		content_str = @escape ? escape_xml @contents : @content
		"<tspan #{attributes_string}>#{content_str}</tspan>"
	end
	
end
