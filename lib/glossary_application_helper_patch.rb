module GlossaryApplicationHelper
  def javascript_include_tag(*sources)
    out = super(*sources)
    if @project.try!(:module_enabled?, 'glossary') and sources.is_a?(Array) and sources[0] == 'jstoolbar/jstoolbar-textile.min'
      out += javascript_tag <<-javascript_tag
jsToolBar.prototype.elements.termlink = {
    type: 'button',
    title: '#{l(:label_tag_termlink)}',
    fn: {
      wiki: function() { this.encloseSelection("{{term(", ")}}") }
    }
}
javascript_tag
      out += stylesheet_link_tag 'termlink', :plugin => 'redmine_glossary'
    end
    out
  end
end

ApplicationHelper.prepend GlossaryApplicationHelper
