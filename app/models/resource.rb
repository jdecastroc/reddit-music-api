#
# Class used to store the songs info which belongs to Reddit.songs array
# 
# author: jdecastroc
# version: 2017/06/11/A
#
class Resource
   
   attr_accessor :url, :source, :name
   def initialize(url, source, name) 
       @url = url
       @source = source
       @name = name
   end
   
end