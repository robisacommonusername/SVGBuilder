require_relative 'SVGObject'
class Stop < SVGObject

	def initialize(stop_colour, offset)
		super
		
		@name = 'stop'
		@attributes.merge!({
			:stop_color => stop_colour,
			:offset => offset
		})
		
		if block_given? yield self end
		return self
	end
end
