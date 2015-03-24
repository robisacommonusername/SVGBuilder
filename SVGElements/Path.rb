require_relative 'AbstractShape'
module SVG
	class Path < AbstractShape
		def initialize(d)
			super()
			@name = 'path'
			@attributes[:d] = d
			
			yield self if block_given?
			return self
		end
		
		#Add some convenience methods for drawing the path section by section
		#These methods all have the same name as the corresponding SVG command
		#e.g. you can draw a triangle like this:
		#self.M(0,0).L(0,1).L(1,0).Z
		#Also available: m, l, H, h, V, v, C, c, S, s, Q, q, T, t, A, a
		command_arities = {:M=>2,:L=>2,:H=>1,:V=>1,:C=>[2,2,2],:S=>[2,2],
			:Q=>[2,2], :T=>2, :A=>7, :Z=>0}
		command_arities.each do |k,v|
			unless v.is_a? Array
				v = [v]
			end
			
			define_method k do |*args|
				formatted_args = v.map{|n| args.slice!(0,n).join(' ')}.join(', ')
				@attributes[:d] += " #{k} #{formatted_args}"
				yield self if block_given?
				return self
			end
			k = k.to_s.downcase.to_sym
			define_method k do |*args|
				formatted_args = v.map{|n| args.slice!(0,n).join(' ')}.join(', ')
				@attributes[:d] += " #{k} #{formatted_args}"
				yield self if block_given?
				return self
			end
		end
		
		#add some alias names
		alias_method :to, :L
		alias_method :line_to, :L
		alias_method :move_to, :M
		alias_method :close_path, :Z
		alias_method :cubic_bezier, :C
		alias_method :quadratic_bezier, :Q
		alias_method :arc, :A
	end
end
