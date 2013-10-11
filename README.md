su-api-exposer
==============
Get code hinting for your IDE and the SketchUp API.  At the moment this is only built for Sublime Text
but you can use the "api.hash" file to try and build your own.

Here is how you might go about doing that

get the API
===========
    ruby get_api.rb
That should do the trick.  It saves the api as a hash in "api.hash".  To use it in your build script do something like
    api = eval(File.open("api.rb").read)

Build an IDE plugin
===================
Every IDE has a different way of dealing with plugins.  You'll have to fight your own battle here.
For sublime I simply build snippets for every class and method.
