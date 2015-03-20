require_relative 'SVGContainer'

class Group < SVGContainer
	include StylableMixin
	include TransformableMixin
	
	def initialize
		super
		stylable_init
		transformable_init
		
		@name = 'g'
		
		if block_given? yield self end
		
		return self
	end
	
end
