## Twitter Demo

This application is a simplistic example of consuming the Twitter
REST API from a Rails app.

It uses the [Twitter gem](https://github.com/sferik/twitter) to
fetch tweets from a user's timeline and display them on the page
in a basic UI.

### Setup

```
git clone https://github.com/turingschool-examples/twitter-demo.git
cd twitter-demo
bundle
rake db:create db:migrate
rails s
```

(Yes, the API credentials are hardcoded in the app. This makes it easier for students to set up.)

Currently this app is being used as a starting point for a Turing
lesson on [Mocking External APIs](https://github.com/turingschool/lesson_plans/blob/master/ruby_04-apis_and_scalability/mocking_apis_v2.markdown).
