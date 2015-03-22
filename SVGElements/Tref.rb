require_relative 'SVGObject'
require_relative '../Mixins/StylableMixin'

class Tref < SVGObject
	include StylableMixin
	
	def initialize(id)
		super
		stylable_init
		
		@name = 'tref'
		@attributes[:"xlink:href"] = id
		
		if block_given? yield self end
		return self
	end
end
