require File.dirname(__FILE__) + '/../test_helper'

class GlossaryControllerTest < ActionController::TestCase
  fixtures :projects, :users, :roles, :members, :member_roles
  plugin_fixtures :terms

  def setup
    @project = projects('projects_001')
    @project.enabled_module_names = [:glossary]
    roles('roles_001').add_permission! :view_terms, :manage_terms
  end

  def test_index
    @request.session[:user_id] = users('users_002').id
    get :index, params: { project_id: 1 }
    assert_response :success
  end
end
