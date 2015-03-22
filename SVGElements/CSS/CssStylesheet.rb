require_relative 'CssClass'
module SVG
	class CssStylesheet
		def initialize
			@classes = []
		end
		
		def add_class(name)
			c = CssClass.new(name)
			if block_given? yield c end
			@classes << c
			return c
		end
		
		def to_css
			@classes.map{|c| c.to_css}.join("\n")
		end
	end
end