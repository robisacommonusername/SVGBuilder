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
	end
end
