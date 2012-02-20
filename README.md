Nano-cal
========

A small library for parsing json formatted events into an iCalendar file, which can be uploaded to google calendar.

Purpose?
--------

The purpose of the nano-cal project is to make it easier to take a set of envents and advance them to a given start date. 

The need arose during a dull Sunday when I needed to advance several events(11), and thought it might just be easier to create a small ruby program to advance a set of events from a json file.

    Usage:
      nano-cal.rb generate <nano_cal.json>
    Options:
      -o, [--output=OUTPUT]  
      -v, [--verbose]

TODO
----

1. make it possible to advance events with a new start date

License
-------

See LICENSE file
