#Some escaping methods, as required
module EscapingMixin
	def escaping_init(do_escape=true)
		#This variable controls whether or not to do XSS escaping
		#it is on by default
		@escape = do_escape
	end
	
	attr_accessor :escape
	alias :"escape?", :escape
	
	def escape_XML(s)
		#Escape the basic entities < > & and "
		#Make sure we escape ampersand first to avoid double escapes
		if (@escape)
			s.gsub('&','&amp;').gsub('<','&lt;').gsub('>','&gt;').gsub('"','&quot;')
		else
			s
		end
	end
	
	def escape_quote(s)
		if (@escape)
			s.gsub('"','&quot;')
		else
			s
		end
	end
end
