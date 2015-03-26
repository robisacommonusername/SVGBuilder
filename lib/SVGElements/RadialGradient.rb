require_relative '../Base/AbstractGradient'

module SVG
	class RadialGradient < SVGAbstract::AbstractGradient
		def initialize
			super()
			@name = 'radialGradient'
			
			yield self if block_given?
			return self
		end
	end
end
