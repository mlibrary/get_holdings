require 'sinatra'
require './models/http_client'

get '/' do
  "Hello World"
end

get '/:mms_id' do |mms_id|
  response = HttpClient.new().get('/bibs/991532650000541/holdings/ALL/items?limit=2&offset=0&expand=due_date&order_by=none&direction=desc&view=brief')
  content_type :json
  response.body
end
