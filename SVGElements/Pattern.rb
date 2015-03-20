require_relative '../Mixins/TransformableMixin'
require_relative '../Mixins/StylableMixin'
class Pattern < SVGContainer
	include TransformableMixin
	include StylableMixin
	
	def initialize(width, height)
		super
		transformable_init
		stylable_init
		
		@name = 'pattern'
		
		@attributes.merge!({
			:width => width,
			:height => height
		})
		
		if block_given? yield self end
		
		return self
	end
end
