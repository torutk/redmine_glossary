class GlossaryTerm < ActiveRecord::Base
  belongs_to :category, class_name: 'GlossaryCategory', foreign_key: 'category_id'
  belongs_to :project
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :updater, class_name: 'User', foreign_key: 'updater_id'

  # class method from Redmine::Acts::Attachable::ClassMethods
  acts_as_attachable view_permission: :view_glossary_terms, edit_permission: :manage_glossary_terms,
                     delete_permission: :manage_glossary_terms

  acts_as_event datetime: :updated_at,
                description: :description,
                author: nil,
                title: Proc.new {|o| "#{l(:glossary_title)} ##{o.id} - #{o.name}" },
                url: Proc.new {|o| { controller: 'glossary_terms',
                                     action: 'show',
                                     id: o.id,
                                     project_id: o.project }
  }

  acts_as_searchable columns: [ "#{table_name}.name", "#{table_name}.description", "#{table_name}.rubi"],
                     preload: [:project ],
                     date_column: "#{table_name}.created_at",
                     scope: joins(:project),
                     permission: :view_glossary_terms

  acts_as_activity_provider scope: joins(:project),
                            type: 'glossary_terms',
                            permission: :view_glossary_terms,
                            timestamp: :updated_at

  scope :search_by_name, -> (keyword) {
    where 'name like ?', "#{sanitize_sql_like(keyword)}%"
  }

  scope :search_by_rubi, -> (keyword) {
    where 'rubi like ?', "#{sanitize_sql_like(keyword)}%"
  }

end
