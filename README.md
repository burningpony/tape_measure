# TapeMeasure

[![Code Climate](https://codeclimate.com/github/burningpony/tape_measure.png)](https://codeclimate.com/github/burningpony/tape_measure)

Contains a text parser for converting various measurements into floating point numbers, as well as doing multiplication with those numbers:

LengthGrammer.parse('6ft') = 72
LengthGrammer.parse('6in') = 6
LengthGrammer.parse('6ft 6in') = 78
LengthGrammer.parse('6 * 6') = 36
LengthGrammer.parse('(6ft 6in) + 6in') = 84

Also contains a to_mixed number function that converts inches to all of it's corresponding measurements:

.to_mixed_number('12') = ['1ft', '12in', '#m', etc]

## Installation: NOT CURRENTLY PUBLISHED


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
