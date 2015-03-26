require_relative '../Base/SVGTextContainer'

class SVG < SVGAbstract::SVGContainer
	class Text < SVGAbstract::SVGTextContainer
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
