#!/usr/bin/env bash

kill -QUIT `cat /tmp/unicorn.pid`
bundle exec unicorn_rails -c /home/umeki/AMIRY_API/config/unicorn.conf.rb -D -E production
