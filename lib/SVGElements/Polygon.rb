require_relative 'AbstractShape'
module SVG
	class Polygon < AbstractShape
		def initialize(*points)
			super()
			@name = 'polygon'
			@attributes[:points] = points.each_slice(2).map{|xy| "#{xy.first} #{xy.last}"}.join(', ')
			
			yield self if block_given?
			return self
		end
		
		def to(x,y)
			@attributes[:points] += ", #{x} #{y}"
			yield self if block_given?
			return self
		end
	end
end
