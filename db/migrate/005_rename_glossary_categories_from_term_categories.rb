class RenameGlossaryCategoriesFromTermCategories < ActiveRecord::Migration[5.2]
  def change
    rename_table :term_categories, :glossary_categories
  end
end