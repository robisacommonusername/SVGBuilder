require_relative 'AbstractShape'
class Rect < AbstractShape
	def initialize(x,y,width,height,rx=nil,ry=nil)
		super
		@name = 'rect'
		@attributes.merge!({
			:x => x,
			:y => y,
			:width => width,
			:height => height,
			:rx => rx,
			:ry => ry
		})
	end
end
