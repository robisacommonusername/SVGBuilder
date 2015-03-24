require_relative 'SVGObject'
require_relative '../Mixins/StylableMixin'

module SVG
	class Tref < SVGObject
		include StylableMixin
		
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
