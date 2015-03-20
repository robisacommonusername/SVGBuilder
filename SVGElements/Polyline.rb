require_relative 'AbstractShape'
class Polyline < AbstractShape
	def initialize(points)
		super
		@name = 'polyline'
		@attributes[:points] = points.each_slice(2).map{|xy| "#{xy.first} #{xy.last}"}.join(', ')
	end
end
