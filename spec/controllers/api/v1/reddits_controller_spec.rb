require "spec_helper"
include ApiHelper



RSpec.describe Api::V1::RedditsController do
  
  context 'when valid parameters' do
    
    it 'parse 3 reddits that exist' do
      
      params = {
        reddit: "jpop+kpop+jazz",
        songs: '20',
        random: 'true',
        order: 'newest'
      }
      
      checkRequest(params, 'success', 200)
      
    end
    
    it '1 Reddits which exist' do
      
      params = {
        reddit: "jazz",
        songs: '20',
        random: 'true',
        order: 'newest'
      }
      
     checkRequest(params, 'success', 200)
      
    end
    
    it '1 Reddits which does not exist' do
      
      params = {
        reddit: "kjhgjfhd",
        songs: '20',
        random: 'true',
        order: 'newest'
      }
      
      checkRequest(params, 'error', 500)
      
    end
    
  end
  
  context "With invalid parameters" do
    
    it 'No reddits entered' do
      
      params = {
        reddit: "",
        songs: '20',
        random: 'true',
        order: 'newest'
      }
      
      checkRequest(params, 'fail', 400)
      
    end
    
    it '2 Reddits which exist and 1 that doesnt exist' do
      
      params = {
        reddit: "jpop+jazz+jrkejkrer",
        songs: '20',
        random: 'true',
        order: 'newest'
      }
      
      checkRequest(params, 'error', 500)
      
    end
    
    it '4 Reddits which exists' do
      
      params = {
        reddit: "jpop+jazz+kpop+classicalmusic",
        songs: '20',
        random: 'true',
        order: 'newest'
      }
      
      checkRequest(params, 'fail', 400)
      
    end
    
    it '1 Reddit which exist and another wich exist but doesnt has resources' do
      
      params = {
        reddit: "jazz+news",
        songs: '20',
        random: 'true',
        order: 'newest'
      }
      
      checkRequest(params, 'error', 500)
      
    end
    
    it 'Too much songs' do
      
      params = {
        reddit: "jazz+jpop",
        songs: '51',
        random: 'true',
        order: 'newest'
      }
      
      checkRequest(params, 'fail', 400)
      
    end
    
  end
  
end