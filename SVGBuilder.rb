#This class provides an RVG-like interface for building SVG documents
#Unlike RVG, it can actually output SVG, not just rasterise everything

require_relative 'SVGElements/SVGContainer'
require_relative 'Mixins/StylableMixin'
require_relative 'Mixins/UnitsMixin'

module SVG
	class SVGBuilder < SVGContainer
		include StylableMixin
		
		def initialize(width, height)
			super()
			stylable_init
			
			@name = 'svg'
			@attributes.merge!({
				:width => width,
				:height => height,
				:version => '1.1',
				:xmlns => "http://www.w3.org/2000/svg"
			})
			@id_ctr = 1 #use for assigning unique ids
			@defs = [] #svg objects that go in the definitions section
			
			#SVG standard doesn't have a way of setting the background
			#It's possible to use the background css attribute, but support
			#is spotty. Therefore, we'll just create a background rectangle
			@background = nil
			
			yield self if block_given?
			
			return self
		end
		
		def new_id
			id = "id_#{@id_ctr}"
			@id_ctr += 1
			return id
		end
		
		def to_xml
			xml = '<?xml version="1.0"?>'
			xml += "\n<svg #{attributes_string} >\n"
			xml += "<defs>#{@defs.map{|o| o.to_xml}.join("\n")}</defs>\n" unless @defs.empty?
			xml += @background.to_xml unless @background.nil?
			xml += "\n"
			xml += @svg_objects.map{|o| o.to_xml}.join("\n")
			xml += "\n</svg>"
			return xml
		end
		
		alias_method :draw, :to_xml #we name it "draw" for compatability with RVG
		
		
		#add something to the defs section of the document, and assign it a
		#unique id
		
		def define(object)
			id = new_id
			object.id = id
			@defs << object
			return ('#' + id)
		end
		alias_method :defs, :define
		
		def viewbox(left, top, right, bottom)
			@attributes[:viewBox] = "#{left} #{top} #{right} #{bottom}"
			
			yield self if block_given?
			
			return self
		end
		
		#RVG compatability method. This seems to work, but it's a bit of a hack
		def background_fill=(colour)
			@background = Rect.new('100%','100%',0,0) if @background.nil?
			@background.styles(:fill=>colour)
		end
		
		#This is a non-RVG method, provided for convenience
		def write(fn)
			open(fn, 'w') do |f|
				f.write self.to_xml
			end
		end
	end
end
