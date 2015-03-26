require_relative '../Base/SVGTextContainer'

module SVG
	class Textpath < SVGAbstract::SVGTextContainer
		def initialize(path_id, do_escape=true)
			super do_escape
			
			@name = 'textPath'
			@attributes[:"xlink:href"] = path_id
			
			yield self if block_given?
			return self
		end
	end
end
