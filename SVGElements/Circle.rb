require_relative 'AbstractShape'
class Circle < AbstractShape
	def initialize(r, x=nil, y=nil)
		super
		@name = 'circle'
		@attributes.merge({
			:r => r,
			:cx => x,
			:cy => y
		})
	end
end
