require_relative 'AbstractShape'
class Polygon < AbstractShape
	def initialize(points)
		super
		@name = 'polygon'
		@attributes[:points] = points.each_slice(2).map{|xy| "#{xy.first} #{xy.last}"}.join(', ')
	end
	
	def to(x,y)
		@attributes[:points] += ", #{x} #{y}"
		if block_given? yield self end
		return self
	end
end
