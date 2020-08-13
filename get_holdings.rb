require 'sinatra'
require "sinatra/reloader" if development?
require './models/holdings'

get '/' do
  "Hello World"
end

get '/:mms_id' do |mms_id|
  response = Holdings.new(mms_id: mms_id).list
  content_type :json
  response.body
end
