require_relative '../Base/SVGObject'
module SVG
	class Stop < SVGAbstract::SVGObject
	
		def initialize(stop_colour, offset)
			super()
			
			@name = 'stop'
			@attributes.merge!({
				:stop_color => stop_colour,
				:offset => offset
			})
			
			yield self if block_given?
			return self
		end
	end
end
