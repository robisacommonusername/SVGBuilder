require_relative 'SVGTextContainer'

class TextPath < SVGTextContainer
	def initialize(path_id, do_escape=true)
		super do_escape
		
		@name = 'textPath'
		@attributes[:"xlink:href"] = path_id
	end
end
