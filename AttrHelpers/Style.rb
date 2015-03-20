#Inline css style
class Style
	def initialize
		@styles = {}
	end
	
	def to_s
		#Note that underscores in key are converted to hyphens.
		#Quotes are entity encoded
		kvpairs = @styles.map do |k,v|
			kk = k.to_s.gsub('_', '-').gsub('"', '&quot;')
			vv = v.to_s.gsub('"', '&quot;')
			"#{kk}: #{vv}"
		end
		return kvpairs.join('; ')
	end
	
	def set_styles(new_styles)
		@styles.merge!(new_styles)
	end
end
