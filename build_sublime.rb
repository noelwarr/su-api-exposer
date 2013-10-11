#The following file generates sublime snippets for the
#SketchUp API.  It evaluates the contents of "api.hash"
#and then uses the hash to generate the snippets
#accordingly

api = eval( File.open(File.join(File.dirname(__FILE__), "api.hash")).read )
path = File.join(File.dirname(__FILE__), "sublime", "SketchUp-API")
blueprint = DATA.read
api.each{|klass,methods|
	snippet = blueprint.gsub("object", klass).
						gsub("(args)", "").
						gsub("trigger", klass)
	target = File.join(path, "#{klass}.sublime-snippet")
	File.open(target, "w+"){|io|
		io.write snippet
	}
	methods.each{|method, arguments|
		safe_method = case method
		when "<=>" 	then "less_equal_greater_than"
		when "<=" 	then "less_equal_to"
		when ">=" 	then "greater_equal_to"
		when "<" 	then "less_than"
		when ">" 	then "greater_than"
		when "*" 	then "multiply"
		else 
			method
		end
		i = 0
		args = arguments.collect{|arg| "${#{i += 1}:#{arg}}"}.join(", ")
		args = "(#{args})" unless args.empty?
		snippet = blueprint.gsub("object", method).
							gsub("(args)", args).
							gsub("trigger", safe_method)
		target = File.join(path, "#{klass}-#{safe_method}.sublime-snippet")
		target.gsub!("?", "Q")
		File.open(target, "w+"){|io|
			io.write snippet
		}
		puts target
		$stdout.flush
	}
}
__END__
<snippet>
	<content><![CDATA[
object(args)
]]></content>
	<!-- Optional: Set a tabTrigger to define how to trigger the snippet -->
	<tabTrigger>trigger</tabTrigger>
	<!-- Optional: Set a scope to limit where the snippet will trigger -->
	<scope>source.ruby</scope>
</snippet>