#Base SVG object, all others inherit from this
class SVGObject
	def initialize
		@attributes = {}
		@name = 'abstract'
	end
	
	def deep_copy
		Marshal.load( Marshal.dump self )
	end
	
	#Some methods for performing escaping of text, etc
	attr_accessor :escape
	alias :"escape?", :escape
	
	private :escape_xml
	def escape_xml(s)
		#Escape the basic entities < > & and "
		#Make sure we escape ampersand first to avoid double escapes
		if (@escape)
			s.gsub('&','&amp;').gsub('<','&lt;').gsub('>','&gt;').gsub('"','&quot;')
		else
			s
		end
	end
	
	private :escape_quote
	def escape_quote(s)
		if (@escape)
			s.gsub('"','&quot;')
		else
			s
		end
	end
	
	private :attributes_string
	#helper methods which will be used in to_xml
	def attributes_string
		#note that underscores are converted to hyphens. Quotes are entity encoded
		attrs = @attributes.reject{|k,v| v.nil?}.map do |k,v|
			vv = escape_quote v.to_s
			kk = k.to_s.gsub('_', '-')
			%Q[#{kk}="#{vv}"]
		end
		
		return attrs.join(' ')
	end
	
	#This is not the way RVG does attribute setting, but it's nicer. Instead
	#of using self.attr1 = value 1, self.attr2 = value2, we should be able
	#to do self.attributes(:attr1 => value1, :attr2 => value2)
	#This method is also chainable and can yield to a block. It's just
	#all round neater.
	#Note that we CANNOT simply do @attributes.merge!(attrs), we instead call
	#each method. The reason for this is that some of the methods have overridden
	#non-default implementations, in particular when an attr helper is required
	#e.g. clip_path. If we simply do a merge, the IdHelper won't be run 
	def attributes(attrs)
		attrs.each do |k,v|
			setter = "#{k}=".to_sym
			self.send(setter, v)
		end
		
		if block_given? yield self end
		
		return self
	end
	
	#Refer to method above, this version disables all attribute helper methods.
	#Potentially useful if you don't know whether there exists a helper or not
	#(e.g. when setting ids), and you want to make sure your code will work
	#without mucking about checking the (non-existent) docs
	def attributes_no_helpers(attrs)
		@attributes.merge! attrs
		if block_given? yield self end
		return self
	end
	
	#Override method missing to provide svg attribute setters/getters.
	#This allows user to use non-standard attributes (which will probably
	#be ignored when the rendered svg file is viewed in a standard viewer)
	#Defining them this way also saves us an enormous amount of work
	#e.g we can do things like "svg.version = 1.1" to set the version
	def method_missing(attr, *vals)
		attr_str = attr.to_s
		case attr_str
		when /^[a-zA-Z_]+$/
			#getter
			if @attributes.has_key? attr
				return @attributes[attr]
			else
				super #method missing
			end
			
		when /^[a-zA-Z_]+=$/
			#setter
			if vals.empty?
				raise ArgumentError, "No arguments provided to attribute setter #{attr_str}"
			end
			@attributes[attr_str.slice(0..-2).to_sym] = vals.first
			
		else
			super #method missing
		end
	end
	
	#Should usually supply an implementation for this method (override in subclass).
	#Default implementation below is for primitive objects only (objects which do
	#not contain other objects, and have self closing tags.) This is sensible, as
	#container objects will usually inherit from SVGContainer, which overrides
	#this default implementation
	def to_xml
		"<#{@name} #{attributes_string} />"
	end
end
