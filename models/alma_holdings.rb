require 'json'
require './models/http_client'
require './models/collections'
require './models/item'
require 'byebug'
class AlmaHoldings
  attr_reader :mms_id, :alma_response
  def initialize(mms_id:,client: HttpClient.new, collections: Collections.new)
    @mms_id = mms_id
    @client = client
    @response = @client.get_all(url: url, record_key: record_key)
    @body = JSON.parse(@response.body)
    @holdings = []
    @collections = collections
    if @response.status == 200 && @body[record_key]
      all_holdings = @body[record_key] 
      uniq_holding_ids = all_holdings.map{|h| h['holding_data']['holding_id']}.uniq
      @holdings = uniq_holding_ids.map do |holding_id|
        holding_list = all_holdings.select{|h| h['holding_data']['holding_id'] == holding_id}
        Holding.new(holding_list: holding_list, collections: collections)
      end
    end
  end
  def to_a
    @holdings
  end
  def url
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

class Holding
  attr_reader :call_number

  def initialize(holding_list:,collections:)
    @bib_data = holding_list.first['bib_data']
    @holding_data = holding_list.first['holding_data']
    @item = holding_list.first['item_data']

    @call_number = @holding_data['call_number']
    @hol_doc_number = @holding_data['holding_id']
    @sub_library = @item['library']['value']
    @collection = @item['location']['value']
    @sub_collection = "#{@sub_library} #{@collection}".chomp
    @info_link = collections.for_code(@sub_collection).lib_info_link
    @location = "#{@item['library']['desc']} #{@item['location']['desc']}".chomp

    @items = holding_list.map{ |h| Item.new(bib: @bib_data, holding: @holding_data, item: h['item_data']).to_h }
  end

  def to_h
    {
      "callnumber" => @call_number,
      "collection" => @collection,
      "hol_doc_number" => @hol_doc_number,
      "info_link" => @info_link,
      "location" => @location,
      "sub_coll" => @sub_collection,
      "sub_library" => @sub_library,
      "item_info" => @items
    }
  end
end
