require_relative '../Mixins/StylableMixin'
require_relative '../Mixins/TransformableMixin'

module SVG
	class ClipPath < SVGAbstract::SVGContainer
		include SVGAbstract::StylableMixin
		include SVGAbstract::TransformableMixin
		
		def initialize
			super()
			stylable_init
			transformable_init
			
			@name = "clipPath"
			
			yield self if block_given?
			return self
		end
	end
end
