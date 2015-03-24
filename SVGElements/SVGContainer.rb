require_relative 'SVGObject'

module SVG
	class SVGContainer < SVGObject
		#Import the svg elements that can be in the container
		@@content_classes = [:rect, :line, :polyline, :polygon, :circle,
			:path, :ellipse, :image, :text, :tspan, :tref, :textpath,
			:anchor, :group, :style, :use]
		@@content_classes.each do |c|
			require_relative c.to_s.capitalize
		end
		
		def initialize
			super()
			@svg_objects = []
		end
		
		#A container may have shapes added to it. Metaprogram them in
		#Don't metaprogram "use" or group, we will give them a custom implemenation
		@@content_classes.reject{|c| c == :use || c==:group}.each do |shape_name|
			define_method(shape_name) do |*args|
				#determine shape class from name, and create an instance
				shape_class_name = shape_name.to_s.capitalize
				shape_class = SVG.const_get(shape_class_name)
				s = shape_class.new(*args) #splat arguments
				
				#user can pass a block, which allows the shape to be customised,
				#however this is not essential. Note that the shape s
				#can be mutated inside the block
				yield s if block_given?
				
				@svg_objects << s
	
				return s 
			end
		end
		
		alias_method :a, :anchor
		
		#The group constructor takes no arguments, which is why we can't just
		#metaprogram it in as above
		def group
			g = Group.new
			yield g if block_given?
			@svg_objects << g
			return g
		end
		#For RVG compatability, the group method should be aliased as g
		alias_method :g, :group
		
		
		#A container can "use" a group or other SVGObject
		def use(svg_object,x=0,y=0)
			#If the svg_object has been added to the defs section of the
			#document, it will have an id. If there's an id, we'll just
			#reference the object from the defs section
			#
			#If there's no id, make a clone of the object, and copy it into
			#the container directly (inefficient for making lots of copies)
			#
			#The user can also assign an id themselves if they want. To avoid
			#conflicts, the id should NOT have the form id_123
			begin
				id = svg_object.id #this may trigger a NoMethodError if there's no id
				use = Use.new(svg_object,x,y)
				
				yield use if block_given?
				 
				@svg_objects << use
				 
				return use
			rescue NoMethodError, e
				#Copy object into container
				#We need to make a copy of the group here to prevent the original
				#being mutated
				copy = svg_object.deep_copy
				copy.translate(x, y) unless (x == 0 && y == 0)
				@svg_objects << copy
				
				yield copy if block_given?
				
				return copy
			end
		end
		
		def to_xml
			xml = "<#{@name} #{attributes_string}>\n"
			xml += @svg_objects.map{|o| o.to_xml}.join("\n")
			xml += "\n</#{@name}>"
			return xml
		end
	end
end
