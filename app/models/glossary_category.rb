class GlossaryCategory < ActiveRecord::Base
  has_many :terms, class_name: 'GlossaryTerm', foreign_key: 'category_id'
  belongs_to :project

  acts_as_positioned

  scope :sorted, lambda { order(:position) }
  
end
