require_relative 'SVGContainer'

class Anchor < SVGContainer
	def initialize
		super
		
		@name = 'a'
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
		super
		
	end
end
