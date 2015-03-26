module SVGAbstract
	class Transformation
		def initialize
			@transforms = []
		end
		
		def to_s
			@transforms.join(' ')
		end
		
		#Meta-program the transformation methods
		transformations = [:rotate, :translate, :scale, :matrix, :skewX, :skewY]
		transformations.each do |t|
			define_method(t) do |*t_args|
				@transforms << "#{t} ( #{t_args.join(' ')} )"
			end
		end
	end
end
