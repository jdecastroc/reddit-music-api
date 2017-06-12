require 'nokogiri'
require 'open-uri'

class Reddit
    
   attr_accessor :name, :resources
   def initialize(name, order, deep) #deep is the songs per reddit number
       @name = "https://www.reddit.com/r/#{name}"
       @resources ||= []
       
       if order.include?("newest")
            get_resources(@name, deep)
       end
       #TODO DO RANDOM PAGE GET RESOURCES
       if order.include?("random")
            get_resources(@name, deep)
       end
   end
   
   def get_resources(url, deep)
       
        begin
        doc = Nokogiri::HTML(open(url, 
	         'User-Agent' => 'web:com.RedditMusicApi.reddit:v1.0 ALPHA by /u/hoppy93'))
	    rescue Exception => e
    	    raise "Couldn't open #{url}, #{e}"
        end
            
      if doc.css("div[data-domain='youtube.com']").blank?
          raise "No resources found in #{url}"
      end
      
	  doc.css("div[data-domain='youtube.com']").css("a.title").map{ |node| 
   
      name = node.content
      url = node['data-href-url'][/(?<=[?&]v=)[^&$]+/]

      @resources.push(Resource.new(url, "youtube", name))
      deep = deep - 1
      puts "Im in name: #{name} and left: #{deep} of #{@name}" #debug purpose
      if deep.zero?
         return @resources.to_json
      end
      }

      next_page = doc.at_css("span.next-button").css('a').attr('href')
      
      get_resources(next_page, deep)
   end
end