require_relative 'SVGTextContainer'

class Text < SVGTextContainer
	def initialize(x,y=nil,do_escape=true)
		super do_escape
		
		@name = 'text'
		@attributes.merge!({
			:x => x,
			:y => y
		})
	end
end
