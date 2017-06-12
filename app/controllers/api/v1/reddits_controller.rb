class Api::V1::RedditsController < Api::V1::BaseController
    
    def action
        @error ||= []
        @resources ||= []
        
        set_params #Set search params
        @error = error_control(@error, @songs, @random, @order, @reddits_url) #Params error control
        
        begin
            parse_resources if @error.empty? #Crawl the reddits
        rescue Exception => e
            return system_error(e)
        end
        @error.empty? ? success(@random, @songs, @order, @last, @resources, @reddits_url) : error(@error)
        
    end
    
    private
    def set_params
        if params[:reddit].present?
            @reddits_url = params[:reddit].split('+')
        end
        
        params[:songs].present? ? @songs = params[:songs].to_i : @songs = 20
        params[:random].present? ? @random = params[:random] : @random = "true"
        params[:order].present? ? @order = params[:order] : @order = "newest"
        
        if params[:last].present?
            if @order == "newest"
                @last = params[:last].to_i
            end
        else
            @last = 0
        end
        
        @res_per_reddit = (@songs.fdiv(@reddits_url.size)).round # Songs per reddit
        #puts "#{@songs} per #{@reddits_url} reddits is #{@res_per_reddit}" #debug
        
    end
    
    def parse_resources
        
        if @random.include?("false")
            begin
            @reddits_url.each { |reddit|
                @resources.push(Reddit.new(reddit, @order, @res_per_reddit))#TODODEEP el ultimo numero
            }
            rescue Exception => e
                raise e
            end
        end
        
        if @random.include?("true")
            begin
            @reddits_url.each { |reddit|
                parsed_reddit = Reddit.new(reddit, @order, @res_per_reddit)
                parsed_reddit.resources.each { |resource|
                    @resources.push(resource)
                }
            }
            rescue Exception => e
                raise e
            end
        end
    end
    
    def system_error(message)
        render status: 500, json: {
            status: "error",
            data: message
        }.to_json
    end
    
    def error(message)
        render status: 400, json: {
            status: "fail",
            data: message
        }.to_json
    end
    
    def success(random, songs, order, last, resources, reddits_url)
        
        if random.include?("false")
            render status: 200, json: {
                status: "success",
            	songs: songs,
            	random: random,
            	order: order,
            	last: last,
                data: {
                    reddits: resources
                 }
            }.to_json
        end
        
        if random.include?("true")
            render status: 200, json: {
                status: "success",
            	songs: songs,
            	random: random,
            	order: order,
            	last: last,
                data: {
                    reddits: reddits_url,
                    resources: resources.shuffle!
                 }
            }.to_json
        end
        
    end
    
end