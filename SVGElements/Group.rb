require_relative 'SVGContainer'

module SVG
	class Group < SVGContainer
		include StylableMixin
		include TransformableMixin
		
		def initialize
			super()
			stylable_init
			transformable_init
			
			@name = 'g'
			
			yield self if block_given?
			
			return self
		end
		
	end
end
