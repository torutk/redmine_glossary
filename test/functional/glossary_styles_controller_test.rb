require File.dirname(__FILE__) + '/../test_helper'

class GlossaryStylesControllerTest < ActionController::TestCase
  fixtures :projects, :users

  def setup
    @project = projects('projects_001')
    @project.enabled_module_names = [:glossary]
  end

  def test_search
    get :search, params: { project_id: @project.identifier, search_str: 'one',  }
    assert_redirected_to controller: :glossary, project_id: @project.identifier, search_str: 'one'
  end

  def test_edit_groupby_category
    user = users('users_002')
    @request.session[:user_id] = user.id
    post :edit, params: { project_id: @project.identifier, glossary_style: { groupby: 1 } }
    assert GlossaryStyle.find_by(user_id: user.id).present?
    assert_redirected_to controller: :glossary, action: :index, project_id: @project.identifier
  end
    
end
