#!/bin/bash

set -e

pushd /home/redmine/redmine

# Plugins
git clone https://github.com/koppen/redmine_github_hook.git plugins/redmine_github_hook
git clone https://github.com/peclik/clipboard_image_paste.git plugins/clipboard_image_paste
git clone https://github.com/eyp/redmine_spent_time.git plugins/redmine_spent_time

bundle update
bundle exec rake redmine:plugins:migrate RAILS_ENV=production

popd

pushd /home/redmine/redmine/public/themes

# Themes
git clone https://github.com/makotokw/redmine-theme-gitmike.git gitmike

popd

#touch /home/redmine/redmine/tmp/restart.txt
echo "コンテナの再起動を実行してください。"