require File.dirname(__FILE__) + '/../test_helper'

class TermTest < ActiveSupport::TestCase
  fixtures :projects, :users
  plugin_fixtures :terms

  def setup
    @term = Term.find(1)
  end

  def test_valid
    assert @term.valid?
  end

  def test_invalid_without_project_id
    @term.project_id = nil
    assert_not @term.valid?
  end

  def test_violation_notnull_author_id
    @term.author_id = nil
    assert_raises ActiveRecord::NotNullViolation do
      @term.save
    end
  end

  def test_invalid_without_name
    @term.name = nil
    assert_not @term.valid?
  end

  def test_author
    assert_equal User.find(3), @term.author
  end

  def test_updater
    assert_equal User.find(3), @term.updater
  end

  def test_project
    assert_equal Project.find(1), @term.project
  end

  def test_datetime_without_updated
    assert_equal '2010-12-13 21:25:16'.to_datetime, @term.datetime
  end

  def test_datetime_with_updated
    term2 = Term.find(2)
    assert_equal '2010-12-14 21:25:16'.to_datetime, term2.datetime
  end

  def test_values
    assert_equal 'eCookbook', @term.value('project')
    assert_empty @term.value('category')
    assert_equal '2010-12-13 21:25:16'.to_datetime, @term.value('datetime')
    assert_equal 'term one', @term.value('name')
    assert_empty @term.value('name_en')
    assert_empty @term.value('codename')
    assert_nil @term.value('description')
  end

  def test_param_to_s
    assert_equal 'term one', @term.param_to_s('name')
  end

  def test_id_comparison
    term1 = Term.find(1)
    assert_equal 0, @term <=> term1
    term2 = Term.find(2)
    assert (@term <=> term2) < 0
    assert (term2 <=> @term) > 0
  end

  def test_self_compare_safe
    assert_equal 0, Term.compare_safe(nil, nil)
    assert_equal -1, Term.compare_safe(@term, nil)
    assert_equal 1, Term.compare_safe(nil, @term)
    term2 = Term.find(2)
    assert_equal 'term one & term two', Term.compare_safe(@term, term2) { @term.name + ' & ' + term2.name }
  end

  def test_self_compare_by_param
    term2 = Term.find(2)
    assert_equal -1, Term.compare_by_param('project', @term, term2)
    assert_equal 1, Term.compare_by_param('category', @term, term2)
    assert_equal 1, Term.compare_by_param('datetime', @term, term2)
    assert_equal -1, Term.compare_by_param('name', @term, term2)
  end

  def test_to_s
    assert_equal '#1: term one', @term.to_s
  end

  def test_self_find_for_macro
    proj = Project.find(1)
    assert_equal @term, Term.find_for_macro('term one', proj)
  end
end
