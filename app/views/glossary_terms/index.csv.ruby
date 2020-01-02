require 'csv'

CSV.generate(row_sep: "\r\n", encoding: "CP932") do |csv|
  column_names =   ["name", "name_en", "category", "datatype", "codename", "description", "rubi", "abbr_whole"]
  csv << column_names
  @glossary_terms.each do |term|
    column_values = [
        term.name,
        term.name_en,
        term.category&.name,
        term.datatype,
        term.codename,
        term.description,
        term.rubi,
        term.abbr_whole
    ]
    csv << column_values
  end
end
