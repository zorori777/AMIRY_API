# AMIRY
Acapella Meetup in Rhythm harmonY
![grape-docs](https://s3-ap-northeast-1.amazonaws.com/amiry-docs/grape-docs.png)

## Concept
 - アカペラのライブ、イベント、教室の様々な情報が集う場所。
 - All the information on Acapella lives, events, and lectures gather.

## Environment
 - Ruby version 2.4.1
 - Rails version 5.1.4

## Installation
```
git clone git@github.com:r-ume/AMIRY.git
bundle install --path vendor/bundle
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
bundle exec rails s
```

