require_relative 'AbstractShape'
class Path < AbstractShape
	def initialize(d)
		super
		@name = 'path'
		@attributes[:d] = d
	end
	
	#Add some convenience methods for drawing the path section by section
	#These methods all have the same name as the corresponding SVG command
	#e.g. you can draw a triangle like this:
	#self.M(0,0).L(0,1).L(1,0).Z
	#Also available: m, l, H, h, V, v, C, c, S, s, Q, q, T, t, A, a
	command_arities = {:M=>2,:L=>2,:H=>1,:V=>1,:C=>[2,2,2],:S=>[2,2],
		:Q=>[2,2], :T=>2, :A=>7}
	command_arities.each do |k,v|
		unless v.is_a? Array
			v = [v]
		end
		
		define_method k do |args|
			formatted_args = v.map{|n| args.slice!(0..n-1).join(' ')}.join(', ')
			@attributes[:d] += " #{k} #{formatted_args}"
			if block_given? yield self end
			return self
		end
		k = k.to_s.downcase.to_sym
		define_method k do |args|
			formatted_args = v.map{|n| args.slice!(0..n-1).join(' ')}.join(', ')
			@attributes[:d] += " #{k} #{formatted_args}"
			if block_given? yield self end
			return self
		end
	end
	
	#add some alias names
	alias :to, :L
	alias :line_to, :L
	alias :move_to, :M
	alias :close_path, :Z
	alias :cubic_bezier, :C
	alias :quadratic_bezier, :Q
	alias :arc, :A
end
