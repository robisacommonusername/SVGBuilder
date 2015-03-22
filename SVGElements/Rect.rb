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
		
		if block_given? yield self end
		return self
	end
	
	# #to allows a rectangle to be drawn from its top left and bottom right
	# coordinates, rather than the top left and the height/width. For
	# example Rect.new(1,1).to(2,2) draws the same square as Rect.new(1,1,1,1)
	def to(right, bottom)
		@attributes[:width] = right - @attributes[:x]
		@attributes[:height] = bottom - @attributes[:y]
		if block_given? yield self end
		return self
	end
end
