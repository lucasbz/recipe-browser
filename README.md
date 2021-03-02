# Recipe Browser

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

### Installing

Clone git repository and run bundle install:

```
$ git clone git@github.com:lucasbz/recipe-browser.git
$ bundle install
```

Update the credentials file:

```
$ EDITOR="code --wait" rails credentials:edit
```

The contents of the file should be like this:

```
contentful:
  space_id: <space_id>
  environment_id: <environment_id>
  access_token: <access_token>

secret_key_base: <secret_key_base>
```

Run the application:

```
$ bundle exec rails s
```

### Running the specs

To run the specs execute following statement:

```
$ bundle exec rspec
```

### Running the linter

To run the linter execute following statement:

```
$ bundle exec rubocop
```

### Running the code coverage

The code coverage report is auto-generated when running the specs