class GlossaryTerm < ActiveRecord::Base
  belongs_to :category, class_name: 'GlossaryCategory', foreign_key: 'category_id'
  belongs_to :project

  # class method from Redmine::Acts::Attachable::ClassMethods
  acts_as_attachable
  
  scope :search_by_name, -> (keyword) {
    where 'name like ?', "#{sanitize_sql_like(keyword)}%"
  }

  scope :search_by_rubi, -> (keyword) {
    where 'rubi like ?', "#{sanitize_sql_like(keyword)}%"
  }

end
