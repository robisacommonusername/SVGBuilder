module SVG
	class CssClass
		def initialize(class_name)
			@class_name = class_name
			@attributes = {}
			yield self if block_given?
			return self
		end
		
		def attributes(attrs)
			@attributes.merge(attrs)
			yield self if block_given?
			return self
		end
		
		def to_css
			css = "#{@class_name} {\n"
			css += @attributes.map{|k,v| "#{k}: #{v}"}.join(";\n")
			css += "}"
			return css
		end
		
		#Override method missing to provide css attribute setters/getters.
		def method_missing(attr, *vals)
			attr_str = attr.to_s
			case attr_str
			when /^[a-zA-Z_]+$/
				#getter
				if @attributes.has_key? attr
					return @attributes[attr]
				else
					super(attr, *vals) #method missing
				end
				
			when /^[a-zA-Z_]+=$/
				#setter
				if vals.empty?
					raise ArgumentError, "No arguments provided to attribute setter #{attr_str}"
				end
				@attributes[attr_str.slice(0..-2).to_sym] = vals.first
				
			else
				super(attr, *vals) #method missing
			end
		end
	end
end
