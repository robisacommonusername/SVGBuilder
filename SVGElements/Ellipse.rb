require_relative 'AbstractShape'
module SVG
	class Ellipse < AbstractShape
		def initialize(rx, ry, cx=0, cy=0)
			super()
			@name = 'ellipse'
			@attributes.merge!({
				:rx => rx,
				:ry => ry,
				:cx => x,
				:cy => y
			})
			
			yield self if block_given?
			return self
		end
	end
end
