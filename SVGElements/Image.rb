require_relative 'SVGObject'
require_relative '../Mixins/TransformableMixin'
require_relative '../Mixins/StylableMixin'

module SVG
	class Image < SVGObject
		include TransformableMixin
		include StylableMixin
		
		def initialize(url)
			super
			transformable_init
			stylable_init
			
			@name = 'image'
			@attributes[:"xlink:href"] = url
			
			if block_given? yield self end
			return self
		end
	end
end