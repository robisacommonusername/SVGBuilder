require_relative 'CssClass'
class SVG < SVGAbstract::SVGContainer
	class CssStylesheet
		def initialize
			@classes = []
		end
		
		def add_class(name)
			c = CssClass.new(name)
			yield c if block_given?
			@classes << c
			return c
		end
		
		def to_css
			@classes.map{|c| c.to_css}.join("\n")
		end
	end
end
