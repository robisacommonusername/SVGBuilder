#We do naughty things and extend the built in Float and Fixnum classes
#to give them methods .in, .cm, .px, etc
#This is just for RVG compatability. It enables us to do things like
#SVGBuilder.new(3.cm, 4.cm) to create a 4x3 centimetre image
module SVG
	module UnitsMixin
		units = [:em, :em, :ex, :px, :in, :cm, :mm, :pt, :pc]
		units.each do |u|
			define_method(u) do
				"#{self}#{u}"
			end
		end
	end
end

class Float
	include SVG::UnitsMixin
end

class Fixnum
	include SVG::UnitsMixin
end
