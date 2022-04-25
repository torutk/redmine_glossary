class RenameGlossaryTermsFromTerms < ActiveRecord::Migration[5.2]
  def change
    remove_column :terms, :tech_en, :string
    remove_column :terms, :name_cn, :string
    remove_column :terms, :name_fr, :string
    change_column :terms, :created_on, :timestamp, default: -> { 'CURRENT_TIMESTAMP' }
    rename_column :terms, :created_on, :created_at
    change_column :terms, :updated_on, :timestamp, default: -> { 'CURRENT_TIMESTAMP' }
    rename_column :terms, :updated_on, :updated_at
    rename_table :terms, :glossary_terms
  end
end
