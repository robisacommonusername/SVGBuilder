require_relative 'AbstractShape'
module SVG
	class Line < AbstractShape
		def initialize(x1=0, y1=0, x2=0, y2=0)
			super()
			@name = 'line'
			@attributes.merge!({
				:x1 => x1,
				:y1 => y1,
				:x2 => x2,
				:y2 => y2
			})
			
			yield self if block_given?
			return self
		end
		
		#some convenience methods
		def move_to(x,y)
			@attributes[:x1] = x
			@attributes[:y1] = y
			yield self if block_given?
			return self
		end
		
		def line_to(x,y)
			@attributes[:x2] = x
			@attributes[:y2] = y
			yield self if block_given?
			return self
		end
		
		alias_method :to, :line_to
	end
end
