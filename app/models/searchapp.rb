class Searchapp < ActiveRecord::Base
  require 'yomu'
  has_many :assets
  attr_accessible :content, :file_name
  attr_accessible :assets_attributes
  accepts_nested_attributes_for :assets, :allow_destroy=> true
  after_create :doc_text


 include PgSearch
  pg_search_scope :search, against: [:file_name, :content],
    using: {tsearch: {dictionary: "english"}},
    associated_against: { assets: [:content]},
    ignoring: :accents

# def self.text_search(query)
#    if query.present?
#      # search(query)
#      rank = <<-RANK
#ts_rank(to_tsvector(file_name), plainto_tsquery(#{sanitize(query)})) 

#RANK
#      where("to_tsvector('english', file_name) @@ :q or to_tsvector('english', content) @@ :q", q: query).order("#{rank} desc")
#    else
#      scoped
#    end
#  end

def self.text_search(query)
    if query.present?
     search(query)
    else
      scoped
    end
  end


  def doc_text
    self.assets.each do |asset|
    yomu = Yomu.new  "#{asset.asset.path}"
    text = yomu.text
    asset.content = text
    asset.save
   end
  end
end

