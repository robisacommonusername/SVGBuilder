require_relative '../Base/AbstractGradient'

class SVG < SVGAbstract::SVGContainer
	class RadialGradient < SVGAbstract::AbstractGradient
		def initialize
			super()
			@name = 'radialGradient'
			
			yield self if block_given?
			return self
		end
	end
end
