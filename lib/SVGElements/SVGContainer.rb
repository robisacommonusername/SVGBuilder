require_relative 'SVGObject'

module SVG
	class SVGContainer < SVGObject
		#Import the svg elements that can be in the container
		#We need to import them within the class to break the circular
		#dependency, some of these classes require the class SVGContainer
		#to be available
		content_classes = [:rect, :line, :polyline, :polygon, :circle,
			:path, :ellipse, :image, :text, :tspan, :tref, :textpath,
			:anchor, :group, :style, :use]
		content_classes.each do |c|
			require_relative c.to_s.capitalize
		end
		
		def initialize
			super()
			@svg_objects = []
		end
		
		#The following methods are for adding shapes, etc. Initially I
		#tried metaprogramming these methods, but it doesn't work well
		#due to the difficulties of using block_given? and yield inside
		#define_method. Thus we need to write all the methods out "long
		# hand". At least this is better for generating documentation.
		
		def rect(*args)
			s = Rect.new(*args)
			yield s if block_given?	
			@svg_objects << s
			return s 
		end
		
		def line(*args)
			s = Line.new(*args)
			yield s if block_given?	
			@svg_objects << s
			return s 
		end
		
		def polyline(*args)
			s = Polyline.new(*args)
			yield s if block_given?	
			@svg_objects << s
			return s 
		end
		
		def polygon(*args)
			s = Polygon.new(*args)
			yield s if block_given?	
			@svg_objects << s
			return s 
		end
		
		def circle(*args)
			s = Circle.new(*args)
			yield s if block_given?	
			@svg_objects << s
			return s 
		end
		
		def path(*args)
			s = Path.new(*args)
			yield s if block_given?	
			@svg_objects << s
			return s 
		end
		
		def ellipse(*args)
			s = Ellipse.new(*args)
			yield s if block_given?	
			@svg_objects << s
			return s 
		end
		
		def image(*args)
			s = Image.new(*args)
			yield s if block_given?	
			@svg_objects << s
			return s 
		end
		
		def text(*args)
			s = Text.new(*args)
			yield s if block_given?	
			@svg_objects << s
			return s 
		end
		
		def tspan(*args)
			s = Tspan.new(*args)
			yield s if block_given?	
			@svg_objects << s
			return s 
		end
		
		def tref(*args)
			s = Tref.new(*args)
			yield s if block_given?	
			@svg_objects << s
			return s 
		end
		
		def textpath(*args)
			s = Textpath.new(*args)
			yield s if block_given?	
			@svg_objects << s
			return s 
		end
		
		def anchor(*args)
			s = Anchor.new(*args)
			yield s if block_given?	
			@svg_objects << s
			return s 
		end
		alias_method :a, :anchor
		
		def style(*args)
			s = Style.new(*args)
			yield s if block_given?	
			@svg_objects << s
			return s 
		end
		
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
