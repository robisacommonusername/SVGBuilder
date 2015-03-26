require_relative '../Base/SVGContainer'

module SVG
	class Anchor < SVGAbstract::SVGContainer
		def initialize(href)
			super()
			
			@name = 'a'
			@attributes[:href] = href
			
			yield self if block_given?
			return self
		end
		
		def to_xml
			#replace the attributes href, actuate, show with
			#xlink:href, xlink:actuate, xlink:show
			#It is possible to specify these symbols with :"xlink:href" etc
			#but its nicer for the user if we just let them type :href
			
			to_fix = @attributes.select{|k,v| k==:href || k==:show || k==:actuate}
			fixed = {}
			to_fix.each do |k,v|
				fixed[:"xlink:#{k}"] = v
			end
			
			@attributes.delete_if{|k,v| k==:href || k==:show || k==:actuate}.merge!(fixed)
			
			#call SVGContainer #to_xml method
			super()
			
		end
	end
end
