require File.dirname(__FILE__) + '/../test_helper'

class TermCategoryTest < ActiveSupport::TestCase
  plugin_fixtures :term_categories

  def setup
    @category = TermCategory.find(1)
  end

  def test_valid
    assert @category.valid?
  end

  def test_invalid_without_name
    @category.name = nil
    assert_not @category.valid?, 'saved term_category without a name'
    assert_not_nil @category.errors[:name], 'no validation error for name present'
  end

  def test_invalide_duplicate_name
    @category.name = 'two'
    assert_not @category.valid?, 'saved term_category with duplicate name'
    assert_not_nil @category.errors[:name], 'no validation error for name duplicate'
  end

  def test_position_comparison
    cat2 = TermCategory.find(2)
    assert_equal 0, @category <=> cat2
    @category.position = 2
    assert (@category <=> cat2) > 0
    @category.position = 0
    assert (@category <=> cat2) < 0
  end

  def test_destroy_without_reassign
    term2 = Term.find(2)
    cat2 = TermCategory.find(2)
    cat2.destroy
    assert_nil term2.category
  end

  def test_destory_with_reassign
    term2 = Term.find(2)
    cat2 = TermCategory.find(2)
    cat2.destroy(@category)
    term2 = Term.find(2)
    assert_equal @category, term2.category
  end
end
