require_relative 'AbstractShape'
module SVG
	class Rect < AbstractShape
		#Personally I'd prefer to have the constructor arguments in the
		#order x,y,width,height, but RVG doesn't do it that way
		def initialize(width,height,x=0,y=0,rx=nil,ry=nil)
			super()
			@name = 'rect'
			@attributes.merge!({
				:x => x,
				:y => y,
				:width => width,
				:height => height,
				:rx => rx,
				:ry => ry
			})
			
			yield self if block_given?
			return self
		end
		
		# #to allows a rectangle to be drawn from its top left and bottom right
		# coordinates, rather than the top left and the height/width. For
		# example Rect.new(1,1).to(2,2) draws the same square as Rect.new(1,1,1,1)
		def to(right, bottom)
			@attributes[:width] = right - @attributes[:x]
			@attributes[:height] = bottom - @attributes[:y]
			yield self if block_given?
			return self
		end
	end
end
