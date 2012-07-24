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


### Category

To create a new category or to switch to an existing category:

    r2do category 'My new category'

or

    r2do category My new category

To display the information of the current category:

    r2do category --display

    # or the shortcut

    r2do now

To permanently delete a Category and its contents:

    r2do category --delete

To list all existing categories:

    r2do display


### Task

To create a new Task or to select an existing one:

    r2do task My Task

or

    r2do task 'My Task'

To view the information regarding a Task:

    r2do task --display

To edit a Task:

    r2do task --edit

To complete a Task:

    r2do task --done

To permanently delete a Task:

    r2do task --delete


### Short command format

All commands support a short format, for example:

    r2do category 'My new category'

    #can be written

    r2do c 'My new category'

To see all the available commands:

    r2do --help


## What is missing?

There are many features presently missing from r2do, which will be implemented in future versions but there is one thing which must be noted here.

1) The ability to move a Task from one Category to another is also missing.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

r2do is released under the Apache License, Version 2.0
