require './models/http_client'
class Holdings
  attr_reader :mms_id, :alma_response
  def initialize(mms_id:,client: HttpClient.new)
    @mms_id = mms_id
    @client = client
    @alma_response = @client.get_all(url: alma_url, record_key: record_key)
  end
  def alma_url
    "/bibs/#{@mms_id}/holdings/ALL/items?&expand=due_date&order_by=none&direction=desc&view=brief"
  end
  def record_key
    'item'
  end
  def list
    @alma_response
  end
  private
end
