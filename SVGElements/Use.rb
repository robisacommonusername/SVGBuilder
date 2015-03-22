require_relative 'AbstractShape'
module SVG
	class Use < AbstractShape
		def initialize(id, x=nil, y=nil)
			super
			@name = 'use'
			
			#Check the supplied id. If it doesn't have a #, add one
			id = '#' + id unless id[0] == '#'
			
			@attributes.merge!({
				:x => x,
				:y => y,
				:"xlink:href" => id
			})
			
			if block_given? yield self end
			return self
		end
	end
end