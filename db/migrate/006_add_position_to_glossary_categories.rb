class AddPositionToGlossaryCategories < ActiveRecord::Migration[5.2]

  def change
    add_column :glossary_categories, :position, :integer, default: nil
  end
end
