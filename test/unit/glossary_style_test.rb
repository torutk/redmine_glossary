require File.dirname(__FILE__) + '/../test_helper'

class GlossaryStyleTest < ActiveSupport::TestCase
  plugin_fixtures :glossary_styles

  def setup
    @style = GlossaryStyle.find(1)
  end

  def test_valid
    assert @style.valid?
  end

  def test_grouping
    assert_not @style.grouping?
    style2 = GlossaryStyle.find(2)
    assert style2.grouping?
  end

  def test_set_default
    @style.set_default!
    assert_not @style.show_desc
    assert_equal 1, @style.groupby
    assert_equal 0, @style.project_scope
    assert_empty @style.sort_item_0
    assert_empty @style.sort_item_1
    assert_empty @style.sort_item_2
  end

  def test_sort_params
    assert_equal ['name', 'name_en'], @style.sort_params
  end

  def test_sort_params_project_category_name
    style2 = GlossaryStyle.find(2)
    assert_equal ['project', 'name'], style2.sort_params
  end
end
