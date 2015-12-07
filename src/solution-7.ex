defmodule Solution7 do

	def run(cmd, {unresloved, resolved}) do
		[input, name] = String.split(cmd, " -> ")
		dep = case String.split(input) do
						[wire1, op, wire2] -> {[wire1, wire2], op} # AND, OR
						["NOT", wire] -> {[wire], "NOT"} 
						[wire, op] -> {[wire], op} # RSHIFT, LSHIFT
						[signal] -> {[], String.to_integer(signal)}
					end
		Enum.reduce([dep | unnresolved], {[], resolved}, &resolve/1)
	end

	resolve(dep, {unresolved, resolved}) ->
		case dep do
			{[], op}
		
	
	
			
			
	  resolve([{wire, input} | unresolved], resolved]
	end

end
