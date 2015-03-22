require_relative 'AbstractShape'
module SVG
	class Ellipse < AbstractShape
		def initialize(rx, ry, cx=nil, cy=nil)
			super
			@name = 'ellipse'
			@attributes.merge!({
				:rx => rx,
				:ry => ry,
				:cx => x,
				:cy => y
			})
			
			if block_given? yield self end
			return self
		end
	end
end