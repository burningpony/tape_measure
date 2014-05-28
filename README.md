# TapeMeasure

[![Code Climate](https://codeclimate.com/github/burningpony/tape_measure.png)](https://codeclimate.com/github/burningpony/tape_measure)
[![Build Status](https://travis-ci.org/burningpony/tape_measure.svg?branch=master)](https://travis-ci.org/burningpony/tape_measure)

Contains a text parser for converting various measurements into their inch :/ equivilent, as well as doing multiplication with those numbers:

TapeMeasure::Parser.new('6ft').parse = 72
TapeMeasure::Parser.new('6in').parse = 6
TapeMeasure::Parser.new('6ft 6in').parse = 78
TapeMeasure::Parser.new('6 * 6').parse = 36
TapeMeasure::Parser.new('(6ft 6in) + 6in').parse = 84

Also contains a formatter that converts a measurement to all of it's corresponding measurements:

.to_mixed_number('12"') = ['1ft', '12in', '#m', etc]

## Installation: 


Add this line to your application's Gemfile:

    gem 'tape_measure'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tape_measure

## Usage

Used for parsing various measurements into a constant measurement. m, cm, ft, in all converted to the corresponding inch
value. Useful for unpredictable input types, common in things such as room size and lumber measurements.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/tape_measure/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
