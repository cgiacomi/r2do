# r2do [![Build Status](https://secure.travis-ci.org/cgiacomi/r2do.png?branch=master)](http://travis-ci.org/cgiacomi/r2do) [![Dependency Status](https://gemnasium.com/cgiacomi/r2do.png)](http://gemnasium.com/cgiacomi/r2do) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/cgiacomi/r2do)

r2do is a simple todo gem to help you remember anything that comes to mind. r2do can be used for normal daily tasks or for your ruby development.

## Installation

Add this line to your application's Gemfile:

    gem 'r2do'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install r2do

## Usage

r2do is still in early development and there are many things missing at present.

As r2do evolves this usage section will reflect the new changes.

At present this is what is available.


To initialize or reset the application:

    r2do initialize

or using the short form of the command:

    r2do init


To create a new category or to switch to an existing category:

    r2do category 'My new category'

or using the short form of the command:

    r2do cat MyProject


To list existing categories:

    r2do display

or using the short form of the command:

    r2do dis


To see the current category:

    r2do current

or

    r2do cur


To create a new Task or to switch to an existing one:

    r2do task MyTask

or:

    r2do new-task 'My new task'



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

r2do is released under the Apache License, Version 2.0
