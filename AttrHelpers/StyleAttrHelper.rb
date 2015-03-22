module SVG
	#Inline css style
	class StyleAttrHelper
		def initialize
			@styles = {}
		end
		
		def to_s
			#Note that underscores in key are converted to hyphens.
			kvpairs = @styles.map do |k,v|
				kk = k.to_s.gsub('_', '-')
				"#{kk}: #{v}"
			end
			return kvpairs.join('; ')
		end
		
		def set_styles(new_styles)
			@styles.merge!(new_styles)
		end
	end
end