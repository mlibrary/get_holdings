require 'excon'
require 'json'
require './models/response'
require 'pry'
class HttpClient
  def initialize(limit: 100)
    @limit = limit
    @headers = {
        'Authorization' => "apikey #{ENV.fetch('ALMA_API_KEY')}",
        'accept' => 'application/json'
      }
  end

  def get(url)
    response = Excon.get( full_url(url), headers: @headers ) 
    case response.status
    when 200
      response
    when 302
      HttpClient.new.get(response.headers['Location'])
    else
      response
    end
  end

  def get_all(url:, record_key:)
    offset = 0
    output = get_range(url: url, offset: offset)
    if output.status == 200
      body = JSON.parse(output.body)
      while  body['total_record_count'] > @limit + offset
        offset = offset + @limit
        my_output = get_range(url: url, offset: offset) 
        if my_output.status == 200
          my_body = JSON.parse(my_output.body)
          my_body[record_key].each {|x| body[record_key].push(x)}
        else
          return my_output #return error
        end
      end 
      Response.new(body: body.to_json) #return good response
    else
      output #return error
    end
  end 

  def symbol(url)
    url.match?('\?') ? '&' : '?'   
  end 

  private 
  def get_range(url:, offset:)
    url = "#{url}#{symbol(url)}limit=#{@limit}&offset=#{offset}"
    get(url) 
  end

  def full_url(url)
    "#{ENV.fetch('ALMA_API_HOST')}/almaws/v1#{url}"
  end
end
