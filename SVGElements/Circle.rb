require_relative 'AbstractShape'
module SVG
	class Circle < AbstractShape
		def initialize(r, x=nil, y=nil)
			super
			@name = 'circle'
			@attributes.merge({
				:r => r,
				:cx => x,
				:cy => y
			})
			
			if block_given? yield self end
			return self
		end
		
		#To allows us to draw a circle without specifying the radius. Instead
		#We specify the centre in the constructor, then call #to with a point
		#on the outside of the circle. For example
		# Circle.new(nil,0,0).to(3,4) is equivalent to Circle.new(5,0,0)
		#Note that in the above, nil has been passed as a dummy value for r to the constructor
		def to(x,y)
			dx = x - @attributes[:cx]
			dy = y - @attributes[:cy]
			r = (dx**2 + dy**2)**(0.5)
			@attributes[:r] = r
			
			if block_given? yield self end
			return self
		end
	end
end