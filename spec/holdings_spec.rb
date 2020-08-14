require 'spec_helper'
require './spec/doubles/excon_response_double'
require './spec/doubles/http_client_get_double'
require './models/alma_holdings'

def url(id)
    "/bibs/#{id}/holdings/ALL/items?&expand=due_date&order_by=none&direction=desc&view=brief"
end

describe AlmaHoldings, 'initialize' do
  context "two holdings" do
    before(:each) do
      response = { url(1234) => ExconResponseDouble.new(body: File.read('./spec/fixtures/alma_two_holdings.json')) }
      dbl = HttpClientGetDouble.new(response)
      holdings = AlmaHoldings.new(mms_id: 1234, client: dbl)
      @first_holding = holdings.to_a[0].to_h
      @second_holding = holdings.to_a[1].to_h
    end
    it 'gets call numbers' do
      expect(@first_holding['callnumber']).to eq('PZ7') 
      expect(@second_holding['callnumber']).to eq('PZ7') 
    end
    it 'gets collection' do
      expect(@first_holding['collection']).to eq('CLC') 
      expect(@second_holding['collection']).to eq('CHIL') 
    end
    it 'gets hol_doc_number' do
      expect(@first_holding['hol_doc_number']).to eq('226159670000951') 
      expect(@second_holding['hol_doc_number']).to eq('225874360000541') 
    end
    it 'gets index'
    it 'gets info_link' do
      expect(@first_holding['info_link']).to eq('http://www.lib.umich.edu/location/hatcher-graduate-library/unit/25') 
      expect(@second_holding['info_link']).to eq('http://www.lib.umich.edu/location/special-collections-library/unit/77') 
    end
    it 'gets location' do
      expect(@first_holding['location']).to eq("Hatcher Graduate Children's Literature Collection - 3rd floor S") 
      expect(@second_holding['location']).to eq("Special Collections Children's Literature") 
    end
    it 'gets public_note'
    it 'gets status'
    it 'gets sub_coll' do
      expect(@first_holding['sub_coll']).to eq('HATCH CLC') 
      expect(@second_holding['sub_coll']).to eq('SPEC CHIL') 
    end
    it 'gets sub_library' do
      expect(@first_holding['sub_library']).to eq('HATCH') 
      expect(@second_holding['sub_library']).to eq('SPEC') 
    end
    it 'gets summary_holdings'
    it 'gets supplementary_material'

    context "one item item_info array" do
      before(:each) do
        @first_item = @first_holding['item_info'].first
        @second_item = @second_holding['item_info'].first
      end

      it 'gets barcode' do
        expect(@first_item['barcode']).to eq('000236159660000951') 
        expect(@second_item['barcode']).to eq('67624') 
      end
      it 'gets bor_id'
      it 'gets bor_status'
      it 'gets call_number' do
        expect(@first_item['callnumber']).to eq('PZ7') 
        expect(@second_item['callnumber']).to eq('PZ7') 
      end
      it 'gets can_book'
      it 'gets can_request'
      it 'gets can_reserve'
      it 'gets chron_i'
      it 'gets chron_j'
      it 'gets collection' do
        expect(@first_item['collection']).to eq('CLC') 
        expect(@second_item['collection']).to eq('CHIL') 
      end
      it 'gets description'
      it 'gets description_sort'
      it 'gets description'
      it 'gets due_date'
      it 'gets due_hour'
      it 'gets enum_a'
      it 'gets enum_b'
      it 'gets enum_c'
      it 'gets full_item_key'
      it "gets hol_doc_number" do
        expect(@first_item['hol_doc_number']).to eq('226159670000951') 
        expect(@second_item['hol_doc_number']).to eq('225874360000541') 
      end
      it "gets inventory_number"
      it "gets item_expected_arrival_date"
      it "gets item_note_opac"
      it "gets item_process_status"
      it "gets item_status"
      it "gets loan_status"
      it 'gets location' do
        expect(@first_item['location']).to eq("Hatcher Graduate Children's Literature Collection - 3rd floor S") 
        expect(@second_item['location']).to eq("Special Collections Children's Literature") 
      end
      it "gets mdp_id"
      it "gets num_requests"
      it "gets opt_out"
      it "gets recall_due_date"
      it "gets status"
      it "gets sub_library" do
        expect(@first_item['sub_library']).to eq('HATCH') 
        expect(@second_item['sub_library']).to eq('SPEC') 
      end
      it "gets temp_location"

    end
    
  end
end
