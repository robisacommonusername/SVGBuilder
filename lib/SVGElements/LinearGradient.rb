require_relative 'AbstractGradient'

module SVG
	class LinearGradient < AbstractGradient
		def initialize
			super()
			@name = 'linearGradient'
		end
	end
end
