#Client error control

module ErrorControl

    extend self
    def error_control(error, songs, random, order, reddits_url)
        
        if reddits_url.size > 3
            @error.push("The max number of reddits to mix is 3")
        end
        
        if songs > 50
            error.push("The max number of songs at once is 50")
        end
        
        if !random.include?("true") && !random.include?("false")
            error.push("Random parameter only accept true or false")
        end
        
        if !order.include?("newest") && !order.include?("random")
            error.push("Order parameter only accepts 'newest' to get the newest songs or 'random' to get random songs")
        end
        
        if !order.include?("newest")
            error.push("The parameter 'last' is not available when the order is not set to 'newest'")
        end
        
        return error
    end
end