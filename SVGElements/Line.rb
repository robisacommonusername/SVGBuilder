require_relative 'AbstractShape'
class Line < AbstractShape
	def initialize(x1, y1, x2, y2)
		super
		@name = 'line'
		@attributes.merge!({
			:x1 => x1,
			:y1 => y1,
			:x2 => x2,
			:y2 => y2
		})
		
		if block_given? yield self end
		return self
	end
	
	#some convenience methods
	def move_to(x,y)
		@attributes[:x1] = x
		@attributes[:y1] = y
		if block_given? yield self end
		return self
	end
	
	def line_to(x,y)
		@attributes[:x2] = x
		@attributes[:y2] = y
		if block_given? yield self end
		return self
	end
	
	alias :to, :line_to
end
