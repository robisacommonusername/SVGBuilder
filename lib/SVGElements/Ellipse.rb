require_relative '../Base/AbstractShape'
class SVG < SVGAbstract::SVGContainer
	class Ellipse < SVGAbstract::AbstractShape
		def initialize(rx, ry, cx=0, cy=0)
			super()
			@name = 'ellipse'
			@attributes.merge!({
				:rx => rx,
				:ry => ry,
				:cx => cx,
				:cy => cy
			})
			
			yield self if block_given?
			return self
		end
	end
end
