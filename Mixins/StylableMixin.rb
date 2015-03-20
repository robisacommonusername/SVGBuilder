require_relative '../AttrHelpers/Style'
module StylableMixin
	def stylable_init
		@attributes[:style] = nil
	end
	
	#styles method, used to apply fill style, etc
	#This is not equivalent to setting (for example) the stroke-width, etc
	#attributes, as it generates a css style string, e.g
	#style="stroke-width: 5; fill: red;"
	def styles(style)
		@attributes[:style] |= Style.new
		
		@attributes[:style].set_styles(style)
		
		if block_given? yield self end
		
		return self
	end
end
