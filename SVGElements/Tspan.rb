require_relative 'SVGObject'
require_relative '../Mixins/StylableMixin'
require_relative '../Mixins/EscapingMixin'
class Tspan < SVGObject
	include StylableMixin
	include EscapingMixin
	
	def initialize(contents)
		super
		stylable_init
		
		@name = 'tspan'
		@contents = contents
	end
	
	def to_xml
		"<tspan #{attributes_string}>#{escape_XML @contents}</tspan>"
	end
	
end
