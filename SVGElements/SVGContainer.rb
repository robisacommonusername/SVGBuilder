require_relative '*'

class SVGContainer < SVGObject	
	def initialize
		super
		@svg_objects = []
	end
	
	#A container may have shapes added to it. Metaprogram them in
	content = [:rect, :line, :polyline, :polygon, :circle,
		:path, :ellipse, :image, :text, :tspan, :tref, :textPath,
		:anchor, :group]
	content.each do |shape_name|
		define_method(shape_name) do |args|
			#determine shape class from name, and create an instance
			shape_class_name = shape_name.to_s.capitalize
			shape_class = Object.const_get(shape_class_name)
			s = shape_class.new(*args) #splat arguments
			
			#user can pass a block, which allows the shape to be customised,
			#however this is not essential. Note that the shape s
			#can be mutated inside the block
			if block_given? yield s end 
			
			@svg_objects << s

			return s 
		end
	end
	
	#For RVG compatability, the group method should be aliased as g
	alias :g, :group
	alias :a, :anchor
	
	#A container can "use" a group or other SVGObject
	def use(svg_object,x=nil,y=nil)
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
			use = Use.new(id,x,y)
			
			if block_given? yield use end
			 
			@svg_objects << use
			 
			return use
		rescue NoMethodError, e
			#Copy object into container
			#We need to make a copy of the group here to prevent the original
			#being mutated
			copy = svg_object.clone
			xy = [x,y].map{|z| z ? z : 0}
			copy.translate(*xy) unless x.nil? and y.nil?
			@svg_objects << copy
			
			if block_given? yield copy end
			
			return copy
		end
	end
	
	def to_xml
		xml = "<#{@name} #{attributes_string}>\n"
		xml += @svg_objects.map{|o| o.to_xml}.join('\n')
		xml += "\n</#{@name}>"
		return xml
	end
end
