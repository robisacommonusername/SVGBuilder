require_relative '../Mixins/StylableMixin'
require_relative '../Mixins/TransformableMixin'

class ClipPath < SVGContainer
	include StylableMixin
	include TransformableMixin
	
	def initialize
		super
		stylable_init
		transformable_init
		
		@name = "clipPath"
	end
end
