# Indexer

Indexer is small RESTful Json API that can index website's page, i.e. parser and store its content.
Given a valid URL address, Indexer will get the contents of the tags h1, h2 and h3 and the URL address from the links.
[![Build Status](https://travis-ci.org/betogrun/indexer.svg?branch=master)](https://travis-ci.org/betogrun/indexer)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

What things you need to install the software and how to install them

```
Ruby 2.4.0
Rails 5.2.1
Postgres 9.2+
```

### Installing

Follow the steps below to get a development environment running

Clone the project

```
$ git clone git@github.com:betogrun/indexer.git
$ cd indexer
```

Install the dependencies

```
$ bundle install
```

Create the database

```
$ rails db:create db:migrate
```

### Running
```
$ rails server
```

## Running the tests

This project uses rspec. The command below will run all the tests

```
$ rspec
```
### Coding style tests

The command below will run the code analyzer and formatter

```
$ rubocop -a
```

## Usage
This API provide two endpoints: 
  * Create (store) a website's page content
  * List all the stored websites (with or without its content)

PS: Make sure the server is up and running.

### Store website's page content

Create a website resource

```
$ curl -i -H "Accept: application/vnd.api+json" -H 'Content-Type:application/vnd.api+json' -X POST -d '{"data": {"type":"websites", "attributes":{"url": "https://alberto-rocha.neocities.org" }}}' http://localhost:3000/api/v1/websites
```

You should get something like this back

```
HTTP/1.1 200 OK
X-Frame-Options: SAMEORIGIN
X-XSS-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Download-Options: noopen
X-Permitted-Cross-Domain-Policies: none
Referrer-Policy: strict-origin-when-cross-origin
Content-Type: application/json; charset=utf-8
ETag: W/"241f975ca0e4ebf44e4f6428f5ddf49f"
Cache-Control: max-age=0, private, must-revalidate
X-Request-Id: a79ae4bb-8f31-4ebe-9213-7c899ed0e290
X-Runtime: 2.509157
Vary: Origin
Transfer-Encoding: chunked

{"data":{"id":"2","type":"websites","links":{"self":"/api/v1/websites/2"},"attributes":{"url":"https://alberto-rocha.neocities.org","indexed":true,"digest":"7d5dc04548134f428c5cf5c1f85902f8"},"relationships":{"tags":{"links":{"self":"/api/v1/websites/2/relationships/tags","related":"/api/v1/websites/2/tags"}}}}}
```


### List stored websites' page content

#### Only websites

To query all websites

```
curl -i -H "Accept: application/vnd.api+json" "http://localhost:3000/api/v1/websites"
```

#### Website with the stored tags

To retrieve all websites with the content of its tags

```
curl -i -H "Accept: application/vnd.api+json" "http://localhost:3000/api/v1/websites?include=tags"
```

More options about query and pagination can be found in this [reference](https://github.com/cerebris/jsonapi-resources/wiki/JSONAPI::Resources-Querystring-Examples)

## Built With

* [Ruby on Rails](https://rubyonrails.org/) - Web framework
* [JSONAPI::Resources](https://maven.apache.org/) - Ruby gem for JSON:API Compliance
* [Nokogiri](http://www.nokogiri.org//) - HTML parser


## Author

* **Alberto Rocha** - [profile](https://github.com/betogrun)


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details


