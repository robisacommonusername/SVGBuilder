require_relative '../Base/SVGContainer'

module SVG
	class Group < SVGAbstract::SVGContainer
		include SVGAbstract::StylableMixin
		include SVGAbstract::TransformableMixin
		
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
