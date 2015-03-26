require_relative '../Base/AbstractShape'
class SVG < SVGAbstract::SVGContainer
	class Path < SVGAbstract::AbstractShape
		def initialize(d)
			super()
			@name = 'path'
			@attributes[:d] = parse_path d
			
			yield self if block_given?
			return self
		end
		
		#Add some convenience methods for drawing the path section by section
		#These methods all have the same name as the corresponding SVG command
		#e.g. you can draw a triangle like this:
		#self.M(0,0).L(0,1).L(1,0).Z
		#Also available: m, l, H, h, V, v, C, c, S, s, Q, q, T, t, A, a
		@@command_arities = {:M=>2,:L=>2,:H=>1,:V=>1,:C=>[2,2,2],:S=>[2,2],
			:Q=>[2,2], :T=>2, :A=>7, :Z=>0}
		@@command_arities.each do |k,v|
			unless v.is_a? Array
				v = [v]
			end
			
			define_method(k) do |*args, &block|
				formatted_args = v.map{|n| args.slice!(0,n).join(' ')}.join(', ')
				@attributes[:d] += " #{k} #{formatted_args}"
				#we can't use yield/block_given? here inside define_method
				#yield self if block_given?
				block.call(self) if block.is_a? Proc
				return self
			end
			k = k.to_s.downcase.to_sym
			define_method(k) do |*args, &block|
				formatted_args = v.map{|n| args.slice!(0,n).join(' ')}.join(', ')
				@attributes[:d] += " #{k} #{formatted_args}"
				#yield self if block_given?
				block.call(self) if block.is_a? Proc
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
		
		#RVG allows paths to be specified that aren't actually quite
		#standard, but manages to interpret them. Thus we'll do that too
		def parse_path(d)
			parsed = ''
			while (off = (d =~ /[A-Za-z]/))
				command = d[off]
				d.slice!(0..off)
				if @@command_arities.has_key? command.upcase.to_sym
					arity = @@command_arities[command.upcase.to_sym]
					arity = [arity] unless arity.is_a? Array
					args = arity.map do |n|
						nums = []
						n.times do |i|
							off = (d =~ /[-0-9]+/)
							off += ($~[0].length-1)
							d.slice!(0..off)
							nums << $~[0]
						end
						nums
					end
					parsed += " #{command} #{args.map{|s| s.join(' ')}.join(', ')}"
				end
			end
			return parsed.slice(1..-1) #cut off initial space
		end
		private :parse_path
	end
end
