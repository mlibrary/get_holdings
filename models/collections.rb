require 'yaml'

class Collections
  def initialize
    file = YAML.load_file('./data/collections.yml')
    @collections = Array.new
    file.each do |c|
      @collections.push(Collection.new(c))
    end
  end
  def for_code(code)
    @collections.find{ |x| x.code == code }
  end
end

class Collection
  attr_reader :code, :lib_info_link, :library_desc, :collection_description
  def initialize(hash)
    @code = hash['code']
    @lib_info_link = hash['lib_info_link']
    @library_desc = hash['library_desc']
    @collection_description = hash['collection_description']
  end
  def to_h
    { code: @code, lib_info_link: @lib_info_link, library_desc: @library_desc, collection_description: @collection_description }
  end
  def to_s
    to_h.to_s
  end
end
