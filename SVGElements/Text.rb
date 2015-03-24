require_relative 'SVGTextContainer'

module SVG
	class Text < SVGTextContainer
		def initialize(x=0,y=0,txt=nil,do_escape=true)
			super do_escape
			
			@name = 'text'
			#Make the default text-anchor middle for RVG compatability
			@attributes.merge!({
				:x => x,
				:y => y,
				:text_anchor => 'middle'
			})
			@text_elements << txt unless txt.nil?
			
			yield self if block_given?
			return self
		end
	end
end
