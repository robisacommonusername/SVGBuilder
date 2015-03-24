require_relative 'SVGContainer'
require_relative 'CSS/CssStylesheet'

module SVG
	class Style < SVGContainer
		def initialize(css)
			super()
			
			@name = 'style'
			@css = 'css'
			@stylesheet = CssStylesheet.new
			
			yield self if block_given?
			return self
		end
		
		def add_class(name)
			c = @stylesheet.add_class(name)
			yield c if block_given?
			return c
		end
		
		def add_css(css)
			@css += css
			yield self if block_given?
			return self
		end
		
		def to_xml
			#need to place css from css and stylesheet into cdata
			xml = "<style>\n"
			xml += "/* <![CDATA[ */\n#{@css}\n#{@stylesheet.to_css}\n /* ]]> */"
			xml += @svg_objects.map{|o| o.to_xml}.join("\n")
			xml += "\n</style>"
		end
	end
end
