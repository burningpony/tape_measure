# TapeMeasure

[![Code Climate](https://codeclimate.com/github/burningpony/tape_measure.png)](https://codeclimate.com/github/burningpony/tape_measure)
[![Build Status](https://travis-ci.org/burningpony/tape_measure.svg?branch=master)](https://travis-ci.org/burningpony/tape_measure)

Contains a text parser for converting various measurements into their inch :/ equivilent, as well as doing multiplication with those numbers:

    TapeMeasure.parse('6ft').parse = 72
    TapeMeasure.parse('6in').parse = 6
    TapeMeasure.parse('6ft 6in').parse = 78
    TapeMeasure.parse('6 * 6').parse = 36
    TapeMeasure.parse('(6ft 6in) + 6in').parse = 84

They underlying library supports all units and could easily be expanded to handle natural lanuage parsing of other units in strings. 
Also contains a formatter that converts a measurement to all of it's corresponding measurements:

    TapeMeasure.format(13.5) = "1' 1 1/2""

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
