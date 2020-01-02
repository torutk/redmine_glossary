# Redmine Glossary Plugin

This is a plugin for Redmine to create a glossary that is a list of terms in a project.

This is a remake version of [the original glossary plugin](https://ja.osdn.net/projects/rp-glossary/releases/). The main goal of remaking is to fit for the recent redmine version to be maintainable.

## The use

- Management of technical terms in a system analysis phase
- Interlinear translation table
- Translate table from term to data type (class name)
- Management of naming examples in a coding

## To get

### Repository

- <https://github.com/torutk/redmine_glossary>

The branches are as follows:

- __master__ for the recent Redmine version
- __develop__ under developping for the next release
- __support/2.x__ original glossary plugin ported for Redmine 2.x
- __support/3.x__ original glossary plugin ported for Redmine 3.x
- __support/4.0or1/based_original__ original glossary plugin ported for Redmine 4.0 or 4.1

### Installation and Setup

1. Copy the plugin directory into the Redmine's plugin directory. Note that the name of plugin's directory should be "redmine_glossary".
2. Migrate plugin task.
3. Restart the redmine.
4. Set permission of glossary plugin in "Administration > Roles and permissions"

### Uninstall

- rails redmine:plugins:migrate NAME=redmine_glossary VERSION=0


