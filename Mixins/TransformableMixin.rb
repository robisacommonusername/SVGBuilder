require_relative '../AttrHelpers/Transformation'
module TransformableMixin
	def transformable_init
		@attributes[:transform] = nil
	end
	
	#metaprogram the transformation methods
	transformations = [:rotate, :translate, :scale, :matrix, :skewX, :skewY]
	transformations.each do |t|
		define_method(t) do |args|
			@attributes[:transform] |= Transformation.new
			@attributes[:transform].send(t, *args)
			
			if block_given? yield self end
			
			return self
		end
	end
end
