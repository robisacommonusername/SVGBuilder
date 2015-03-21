require_relative 'SVGContainer'
require_relative 'CssStylesheet'

class Style < SVGContainer
	def initialize(css)
		super
		
		@name = 'style'
		@css = 'css'
		@stylesheet = CssStylesheet.new
		
		if block_given? yield self end
		return self
	end
	
	def add_class(name)
		c = @stylesheet.add_class(name)
		if block_given? yield c end
		return c
	end
	
	def add_css(css)
		@css += css
	end
	
	def to_xml
		#need to place css from css and stylesheet into cdata
		xml = "<style>\n"
		xml += "/* <![CDATA[ */\n#{@css}\n#{@stylesheet.to_css}\n /* ]]> */"
		xml += @svg_objects.map{|o| o.to_xml}.join("\n")
		xml += "\n</style>
	end
end
