require 'spec_helper'
require 'pry'

describe 'test' do
  it 'is a test test' do
    get '/'
    expect(last_response.body).to include('World')
  end
end
