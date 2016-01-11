#!/bin/bash
# My test scripts for WikiPad
# $./run_tests.sh to execute
echo "Running your scripts for WikiPad"

rspec spec/controllers/users_controller_spec.rb
rspec spec/controllers/wikis_controller_spec.rb
rspec spec/models/wiki_spec.rb
rspec spec/models/user_spec.rb
