#!/usr/bin/env bash

kill -QUIT `cat /home/umeki/AMIRY_API/tmp/pids/unicorn.pid`
bundle exec unicorn_rails -c /home/umeki/AMIRY_API/config/unicorn.conf.rb -D -E production
