module SVGAbstract
	class IdHelper
		def initialize(id)
			@id = id
		end
		
		def to_s
			#if an id has been supplied, wrap in url(), otherwise do nothing
			return @id[0] == '#' ? "#url(#{@id})" : @id
		end
	end
end
