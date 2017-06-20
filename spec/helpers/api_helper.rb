module ApiHelper
  
  def json
      JSON.parse(response.body)
  end
  
  def checkRequest(params, expectedResponse, expectedStatus)
    get :action, params
    expect(response).to have_http_status(expectedStatus)
    expect(json['status']).to eq(expectedResponse)
  end
  
end
