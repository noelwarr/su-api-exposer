#This file fetches a series of html files form the Sketchup
#API site, parses them and generates a hash object with the
#following structure
# {"object":{"method":["arg1", "arg2"]}}
#Results are saved to "api.hash"
require 'net/http'

api = Hash.new
base_url = "http://www.sketchup.com/intl/en/developer/docs/"
uri = URI(base_url + "classes.php")
html = Net::HTTP.get(uri)
klasses = html.scan(/<li><a href=\"(.*?)\">(.*?)<\/a><\/li>/)
klasses.each{|url, class_name|
	klass = Hash.new
	api[class_name] = klass
	uri = URI(base_url + url)
	html = Net::HTTP.get(uri)
	refferences = html.scan(/(<dl class="apireference">)(.*?)(<div class="line"><\/div>|<p class="post">)/m)
	refferences.each{|_, ref, _|
		method = ref.scan(/<span class="itemname">.*?\.(.*?)<\/span>/)[0][0]
		args = ref.scan(/<dt class="argname">(.*?)<\/dt>/).flatten
		klass[method] = args
	}
	puts klass.inspect
	$stdout.flush
}
File.open(File.join(File.dirname(__FILE__), "api.hash"), "w+"){|io|
	io.write api.inspect
}