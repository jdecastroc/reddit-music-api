class Api::V1::RedditsController < Api::V1::BaseController
    
    def action
        @error ||= []
        
        set_params
        if @error.empty?
            success
        end
        error
    end
    
    private
    def set_params
        if params[:reddit].present?
            @reddits_url = params[:reddit].split('+')
        end
        
        if @reddits_url.size > 3
            @error.push("The max number of reddits to mix is 3")
        end
        
        params[:songs].present? ? @songs = params[:songs].to_i : @songs = 20
        params[:random].present? ? @random = params[:random] : @random = "true"
        params[:order].present? ? @order = params[:order] : @order = "newest"
        
        #TODO check this
        if params[:last].present?
            if @order == "newest"
                @last = params[:last].to_i
            else
                @error.push("The parameter 'last' is not available when the order is set to random")
            end
            
        else
            @last = 0
        end
    end
    
    def error
        render status: 400, json: {
            status: "fail",
            data: @error
        }.to_json
    end
    
    def success
        render status: 200, json: {
            status: "success",
        	songs: @songs,
        	random: @random,
        	order: @order,
        	last: @last,
            data: {
                reddits: @reddits_url
             }
        }.to_json
    end
end