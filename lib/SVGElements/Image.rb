require_relative '../Base/SVGObject'
require_relative '../Mixins/TransformableMixin'
require_relative '../Mixins/StylableMixin'

module SVG
	class Image < SVGAbstract::SVGObject
		include SVGAbstract::TransformableMixin
		include SVGAbstract::StylableMixin
		
		def initialize(url, width=nil, height=nil, x=0, y=0)
			super()
			transformable_init
			stylable_init
			
			@name = 'image'
			@attributes[:"xlink:href"] = url
			
			yield self if block_given?
			return self
		end
	end
end
