require File.dirname(__FILE__) + '/../test_helper'

class TermCategoriesControllerTest < ActionController::TestCase
  fixtures :projects, :users, :roles, :members, :member_roles

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
end
