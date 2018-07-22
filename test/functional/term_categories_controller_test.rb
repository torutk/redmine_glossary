require File.dirname(__FILE__) + '/../test_helper'

class TermCategoriesControllerTest < ActionController::TestCase
  fixtures :projects, :users, :roles, :members, :member_roles, :term_categories
  plugin_fixtures :term_categories, :terms

  def setup
    @project = projects('projects_001')
    @project.enabled_module_names = [:glossary]
    roles('roles_001').add_permission! :manage_term_categories
  end

  def test_index_response
    @request.session[:user_id] = users('users_002').id
    get :index, params: { project_id: 1 }
    assert_response :success
  end

  def test_edit
    @request.session[:user_id] = users('users_002').id
    patch :edit, params: { id: 1, project_id: 1, category: { name: 'eins' } }
    category = TermCategory.find(1)
    assert_redirected_to controller: :term_categories, project_id: @project.identifier
    assert_equal 'eins', category.name
  end

  def test_change_order
    @request.session[:user_id] = users('users_002').id
    post :change_order, params: { id: 1, project_id: 1, position: 'lower' }
    category = TermCategory.find(1)
    assert_equal 2, category.position
  end

  def test_destroy_without_reassign
    @request.session[:user_id] = users('users_002').id
    post :destroy, params: { id: 1, project_id: 1 }
    assert_raise(ActiveRecord::RecordNotFound) { TermCategory.find(1) }
    assert_redirected_to controller: :term_categories, project_id: @project.identifier
  end

  def test_destroy_with_reassign
    @request.session[:user_id] = users('users_002').id
    post :destroy, params: { id: 2, project_id: 1, todo: 'reassign', reassign_to_id: 1 }
    assert_equal 1, Term.find(2).category_id
    assert_redirected_to controller: :term_categories, project_id: @project.identifier
  end
end
