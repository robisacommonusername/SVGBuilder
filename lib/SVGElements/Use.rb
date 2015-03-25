require_relative 'AbstractShape'
module SVG
	class Use < AbstractShape
		def initialize(svg_object, x=nil, y=nil)
			super()
			@name = 'use'
			
			#Check the supplied id. If it doesn't have a #, add one
			#Note that this may trigger an exception if the object doesn't have an id
			id = svg_object.id
			id = '#' + id unless id[0] == '#'
			
			@attributes.merge!({
				:x => x,
				:y => y,
				:"xlink:href" => id
			})
			
			yield self if block_given?
			return self
		end
	end
end
