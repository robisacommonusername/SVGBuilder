require_relative 'AbstractShape'
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
	end
end
