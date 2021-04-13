require 'elasticsearch/model'
class Election < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  belongs_to :group
  has_many :votes

  CATEGORIES = ['College Representative', 'President', 'Vice President']
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  
  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['name', 'category']
          }
        }
      }
    )
  end
end
Election.__elasticsearch__.create_index!
Election.import
