require_relative '../Base/SVGObject'
require_relative '../Mixins/StylableMixin'

module SVG
	class Tref < SVGAbstract::SVGObject
		include SVGAbstract::StylableMixin
		
		def initialize(id)
			super()
			stylable_init
			
			@name = 'tref'
			@attributes[:"xlink:href"] = id
			
			yield self if block_given?
			return self
		end
	end
end
