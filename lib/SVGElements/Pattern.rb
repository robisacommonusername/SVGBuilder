require_relative '../Mixins/TransformableMixin'
require_relative '../Mixins/StylableMixin'
module SVG
	class Pattern < SVGContainer
		include TransformableMixin
		include StylableMixin
		
		def initialize(width=0, height=0, x=0, y=0)
			super()
			transformable_init
			stylable_init
			
			@name = 'pattern'
			
			@attributes.merge!({
				:width => width,
				:height => height,
				:x => x,
				:y => y
			})
			
			yield self if block_given?
			
			return self
		end
	end
end
