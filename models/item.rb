class Item
  def initialize(bib:,holding:,item:)
    @bib = bib
    @holding = holding
    @item = item

    @barcode = @item['barcode']
    @call_number = @holding['call_number']
    @collection = @item['location']['value']
    @holding_id = @holding['holding_id']
    @location = "#{@item['library']['desc']} #{@item['location']['desc']}".chomp
    @sub_library = @item['library']['value']
  end

  def to_h
    {
      "barcode" => @barcode,
      "callnumber" => @call_number,
      "collection" => @collection,
      "hol_doc_number" => @holding_id,
      "location" => @location,
      "sub_library" => @sub_library,
    }
  end
end
