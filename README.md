Nano-cal
========

A small library for parsing json formatted events into an iCalendar file, which can be uploaded to google calendar.

Purpose?
--------

The purpose of the nano-cal project is to make it easier to take a set of envents and advance them to a given start date. 

The need arose during a dull Sunday when I needed to advance several events(11), and thought it might just be easier to create a small ruby program to advance a set of events from a json file.

Usage
-----

    Usage:
      nano-cal.rb generate <nano_cal>
    Options:
      -o, [--output=OUTPUT]                  
      -d, [--new-start-date=NEW_START_DATE]  
      -v, [--verbose]

Example:
    #Advance events to specified date and generate iCalendar
    ruby nano-cal.rb generate spec/json/nano-cal.json -d "2012-02-24"

TODO
----

1. make it possible to advance events with a new start date

License
-------

See LICENSE file
