#The text class is transformable and stylable. It is also a container,
#However it does not use the container mixin, as it can only "contain"
#certain kinds of elements (i.e. tspan)
#
#Text element also has special treatment of text between tags
#i.e. <text>An <tspan>important</tspan> message</text>. We need to be
#able to do entity escaping on the text in case the user tries to change
#the text content to something like "</text><scipt>alert('XSS')</script><text>"

#Forward declaration to allow the text content elements, some of which 
#inherit from text container to be imported
require_relative 'SVGObject'
require_relative '../Mixins/TransformableMixin'
require_relative '../Mixins/StylableMixin'

module SVGAbstract
	class SVGTextContainer < SVGObject
		include TransformableMixin
		include StylableMixin
		
		#Import text elements
		content_classes = [:tspan, :anchor, :tref, :textpath]
		content_classes.each do |c|
			require_relative "../SVGElements/#{c.to_s.capitalize}"
		end
		
		def initialize(do_escape=true)
			super()
			transformable_init
			stylable_init
			@escape = do_escape
			
			@name = 'abstracttextcontainer'
			
			#textelements can be either strings (i.e. actual text), or SVGObjects
			#like tspan. The strings must be entity escaped
			#The tspan elements will not be entity escaped here, it is assumed
			#that tspan does its own escaping
			@svg_objects = []
			
			yield self if block_given?
			
			return self
		end
		
		def <<(txt)
			@svg_objects << txt
		end
		
		def text(*args)
			s = SVG::Text.new(*args)
			yield s if block_given?	
			@svg_objects << s
			return s 
		end
		
		def tspan(*args)
			s = SVG::Tspan.new(*args)
			yield s if block_given?	
			@svg_objects << s
			return s 
		end
		
		def tref(*args)
			s = SVG::Tref.new(*args)
			yield s if block_given?	
			@svg_objects << s
			return s 
		end
		
		def textpath(*args)
			s = SVG::Textpath.new(*args)
			yield s if block_given?	
			@svg_objects << s
			return s 
		end
		
		def anchor(*args)
			s = SVG::Anchor.new(*args)
			yield s if block_given?	
			@svg_objects << s
			return s 
		end
		alias_method :a, :anchor
		
		def to_xml
			xml = "<#{@name} #{attributes_string}>"
			xml += @svg_objects.map{|t|
				if t.is_a? String
					@escape ? (escape_xml t) : t
				else
					t.to_xml
				end
			}.join('')
			xml += "</#{@name}>\n"
		end
	end
end
