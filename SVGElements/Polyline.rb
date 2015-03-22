require_relative 'AbstractShape'
module SVG
	class Polyline < AbstractShape
		def initialize(points)
			super
			@name = 'polyline'
			@attributes[:points] = points.each_slice(2).map{|xy| "#{xy.first} #{xy.last}"}.join(', ')
			
			if block_given? yield self end
			return self
		end
		
		def to(x,y)
			@attributes[:points] += ", #{x} #{y}"
			if block_given? yield self end
			return self
		end
		
	end
end