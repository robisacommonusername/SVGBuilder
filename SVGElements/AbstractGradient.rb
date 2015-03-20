require_relative 'SVGObject'
require_relative '../Mixins/StylableMixin'

class AbstractGradient < SVGObject
	include StylableMixin
	
	def initialize
		super
		stylable_init
		
		@stops = []
		@name = 'abstractGradient'
		if block_given? yield self end
		
		return self
	end
	
	def stop(stop_colour, offset)
		s = Stop.new(stop_colour, offset)
		
		if block_given? yield s end
		
		@stops << s
	
		return s
	end
	
	def to_xml
		xml = "<#{@name} #{attributes_string}>\n"
		xml += @stops.map{|o| o.to_xml}.join("\n")
		xml += "\n</#{@name}>"
		return xml
	end
	
end
