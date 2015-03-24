require_relative '../AttrHelpers/Transformation'
module SVG
	module TransformableMixin
		def transformable_init
			@attributes[:transform] = nil
		end
		
		#metaprogram the transformation methods
		transformations = [:rotate, :translate, :scale, :matrix, :skewX, :skewY]
		transformations.each do |t|
			define_method(t) do |*args|
				@attributes[:transform] = Transformation.new() if @attributes[:transform].nil?
				@attributes[:transform].send(t, *args)
				
				yield self if block_given?
				
				return self
			end
		end
	end
end
