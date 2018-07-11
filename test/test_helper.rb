# -*- coding: utf-8 -*-
# Load the normal Rails helper
require File.expand_path(File.dirname(__FILE__) + '/../../../test/test_helper')

module Redmine
  module PluginFixturesLoader
    def self.included(base)
      base.class_eval do
        def self.plugin_fixtures(*symbols)
          ActiveRecord::FixtureSet.create_fixtures(File.dirname(__FILE__) + '/fixtures/', symbols)
        end
      end
    end
  end
end

## ファンクショナルテスト
unless ActionController::TestCase.included_modules.include?(Redmine::PluginFixturesLoader)
  ActionController::TestCase.send :include, Redmine::PluginFixturesLoader
end
## ユニットテスト
unless ActiveSupport::TestCase.included_modules.include?(Redmine::PluginFixturesLoader)
  ActiveSupport::TestCase.send :include, Redmine::PluginFixturesLoader
end
## インテグレーションテスト
unless Redmine::IntegrationTest.included_modules.include?(Redmine::PluginFixturesLoader)
  Redmine::IntegrationTest.send :include, Redmine::PluginFixturesLoader
end

