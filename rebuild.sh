#!/bin/bash
#jekyll build --source ./bitwiser/ --destination ./_site/ #--incremental
#jekyll build --source ./startbootstrap/ --destination ./_site/ #--incremental

# Set PATH, to allow running from cron
PATH=/usr/local/rvm/gems/ruby-2.3.0/bin:/usr/local/rvm/gems/ruby-2.3.0@global/bin:/usr/local/rvm/rubies/ruby-2.3.0/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/local/rvm/bin

jekyll build --source ./startbootstrap/ --destination ./_site/ -q
