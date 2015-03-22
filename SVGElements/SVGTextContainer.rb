#The text class is transformable and stylable. It is also a container,
#However it does not use the container mixin, as it can only "contain"
#certain kinds of elements (i.e. tspan)
#
#Text element also has special treatment of text between tags
#i.e. <text>An <tspan>important</tspan> message</text>. We need to be
#able to do entity escaping on the text in case the user tries to change
#the text content to something like "</text><scipt>alert('XSS')</script><text>"
require_relative 'SVGObject'
require_relative '../Mixins/TransformableMixin'
require_relative '../Mixins/StylableMixin'
require_relative 'Tspan'
require_relative 'Anchor'
require_relative 'Tref'
require_relative 'TextPath'

class SVGTextContainer < SVGObject
	include TransformableMixin
	include StylableMixin
	include EscapingMixin
	
	def initialize(do_escape=true)
		super
		transformable_init
		stylable_init
		@escape = do_escape
		
		@name = 'abstracttextcontainer'
		
		#textelements can be either strings (i.e. actual text), or SVGObjects
		#like tspan. The strings must be entity escaped
		#The tspan elements will not be entity escaped here, it is assumed
		#that tspan does its own escaping
		@text_elements = []
		
		if block_given? yield self end
		
		return self
	end
	
	def text(t)
		@text_elements << t
		
		if block_given? yield self end
		
		return self
	end
	
	#The following elements can be included inside a text node, and we metaprogram
	#in their convenience methods:
	text_contents = [:tspan, :anchor, :tref, :textPath]
	text_contents.each do |m|
		define_method(m) do |args|
			m_class = Object.const_get(m.to_s.capitalize)
			
			obj = m_class.new(*args)
			
			if block_given? yield obj end
			
			@text_contents << obj
			
			return obj
		end
	end
	alias :a, :anchor
	
	def to_xml
		xml = "<#{@name} #{attributes_string}>"
		xml += @text_elements.map{|t|
			if t.is_a? String
				@escape ? escape_xml t : t
			else
				t.to_xml
			end
		}.join('')
		xml += "</#{@name}>"
	end
end
