class RenameGlossaryViewSettingsFromGlossaryStyles < ActiveRecord::Migration[5.2]
  def change
    rename_table :glossary_styles, :glossary_view_settings
  end
end