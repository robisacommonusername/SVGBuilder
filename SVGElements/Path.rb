require_relative 'AbstractShape'
class Path < AbstractShape
	def initialize(d)
		super
		@name = 'path'
		@attributes[:d] = d
	end
end
