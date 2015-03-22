require_relative 'AbstractGradient'

module SVG
	class RadialGradient < AbstractGradient
		def initialize
			super
			@name = 'radialGradient'
		end
	end
end