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

module SVG
	class SVGTextContainer < SVGObject
		include TransformableMixin
		include StylableMixin
		
		#Import text elements
		content_classes = [:tspan, :anchor, :tref, :textpath]
		content_classes.each do |c|
			require_relative c.to_s.capitalize
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
			@text_elements = []
			
			yield self if block_given?
			
			return self
		end
		
		def <<(txt)
			@text_elements << txt
			yield self if block_given?
			return self
		end
		
		def text(*args)
			s = Text.new(*args)
			yield s if block_given?	
			@text_elements << s
			return s 
		end
		
		def tspan(*args)
			s = Tspan.new(*args)
			yield s if block_given?	
			@text_elements << s
			return s 
		end
		
		def tref(*args)
			s = Tref.new(*args)
			yield s if block_given?	
			@text_elements << s
			return s 
		end
		
		def textpath(*args)
			s = Textpath.new(*args)
			yield s if block_given?	
			@text_elements << s
			return s 
		end
		
		def anchor(*args)
			s = Anchor.new(*args)
			yield s if block_given?	
			@text_elements << s
			return s 
		end
		alias_method :a, :anchor
		
		def to_xml
			xml = "<#{@name} #{attributes_string}>"
			xml += @text_elements.map{|t|
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
