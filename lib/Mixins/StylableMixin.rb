require_relative '../AttrHelpers/StyleAttrHelper'
module SVGAbstract
	module StylableMixin
		def stylable_init
			@attributes[:style] = nil
		end
		
		#styles method, used to apply fill style, etc
		#This is not equivalent to setting (for example) the stroke-width, etc
		#attributes, as it generates a css style string, e.g
		#style="stroke-width: 5; fill: red;"
		def styles(style)
			@attributes[:style] = StyleAttrHelper.new() if @attributes[:style].nil?
			
			@attributes[:style].set_styles(style)
			
			yield self if block_given?
			
			return self
		end
	end
end
