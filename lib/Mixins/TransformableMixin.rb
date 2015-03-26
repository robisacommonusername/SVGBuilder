require_relative '../AttrHelpers/Transformation'
module SVGAbstract
	module TransformableMixin
		def transformable_init
			@attributes[:transform] = nil
		end
		
		#Transformation methods
		def rotate(t=0, *args)
			@attributes[:transform] = Transformation.new() if @attributes[:transform].nil?
			@attributes[:transform].rotate(t, *args)
			yield self if block_given?
			return self
		end
		
		def translate(x=0,y=0)
			@attributes[:transform] = Transformation.new() if @attributes[:transform].nil?
			@attributes[:transform].translate(x,y)
			yield self if block_given?
			return self
		end
		
		def scale(ax,ay=1)
			@attributes[:transform] = Transformation.new() if @attributes[:transform].nil?
			@attributes[:transform].scale(ax,ay)
			yield self if block_given?
			return self
		end
		
		def skewX(t=0)
			@attributes[:transform] = Transformation.new() if @attributes[:transform].nil?
			@attributes[:transform].skewX(t)
			yield self if block_given?
			return self
		end
		
		def skewY(t=0)
			@attributes[:transform] = Transformation.new() if @attributes[:transform].nil?
			@attributes[:transform].skewY(t)
			yield self if block_given?
			return self
		end
		
		def matrix(a=1,b=0,c=0,d=0,e=1,f=0)
			@attributes[:transform] = Transformation.new() if @attributes[:transform].nil?
			@attributes[:transform].rotate(t)
			yield self if block_given?
			return self
		end
	end
end
