require_relative 'AbstractGradient'

class LinearGradient < AbstractGradient
	def initialize
		super
		@name = 'linearGradient'
	end
end
