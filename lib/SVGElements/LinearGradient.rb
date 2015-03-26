require_relative '../Base/AbstractGradient'

module SVG
	class LinearGradient < SVGAbstract::AbstractGradient
		def initialize
			super()
			@name = 'linearGradient'
			
			yield self if block_given?
			return self
		end
	end
end
