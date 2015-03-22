require_relative 'SVGObject'
require_relative '../Mixins/TransformableMixin'
require_relative '../Mixins/StylableMixin'
require_relative '../AttrHelpers/IdHelper'

class AbstractShape < SVGObject
	include TransformableMixin
	include StylableMixin
	
	def initialize
		super
		transformable_init
		stylable_init
		
		@name = 'abstractshape'
		@attributes[:clip_path] = nil
		
		if block_given? yield self end
		return self
	end
	
	#The following attributes might be ids, which need to be wrapped as
	#  url(#id). However, they may not be ids too. Thus we use the IdHelper
	#object here
	maybe_id_methods = [:clip_path, :fill, :stroke]
	maybe_id_methods.each do |m|
		define_method(m) |maybe_id|
			@attributes[m] = IdHelper.new(maybe_id)
		end
	end
end
