require "spec_helper"

class AdvanceTest
  attr_accessor :events
  include NanoCal::Export
end

describe NanoCal::Export do
  it "advances one event" do
    event = NanoCal::Models::Event.new(:title => "Test", :start => "2012-04-13 19:00:00 +0100", :stop => "2012-04-13 22:00:00 +0100")

    pt = AdvanceTest.new
    pt.events = [event]
    pt.advance_to("2012-02-24")

    pt.events.first.should == NanoCal::Models::Event.new(:title => "Test", :start => "2012-02-24 19:00:00 +0100", :stop => "2012-02-24 22:00:00 +0100")
  end

  it "advances multiple events" do
    event1 = NanoCal::Models::Event.new(:title => "Test", :start => "2012-04-13 19:00:00 +0100", :stop => "2012-04-13 22:00:00 +0100")
    event2 = NanoCal::Models::Event.new(:title => "Test", :start => "2012-04-14 09:00:00 +0100", :stop => "2012-04-14 10:30:00 +0100")

    pt = AdvanceTest.new
    pt.events = [event1,event2]
    pt.advance_to("2012-02-24")

    pt.events.last.should == NanoCal::Models::Event.new(:title => "Test", :start => "2012-02-25 09:00:00 +0100", :stop => "2012-02-25 10:30:00 +0100")
  end

  it "advances an event, month wrapover" do
    event1 = NanoCal::Models::Event.new(:title => "Test", :start => "2012-04-13 19:00:00 +0100", :stop => "2012-04-13 22:00:00 +0100")
    event2 = NanoCal::Models::Event.new(:title => "Test", :start => "2012-04-14 09:00:00 +0100", :stop => "2012-04-14 10:30:00 +0100")

    pt = AdvanceTest.new
    pt.events = [event1,event2]
    pt.advance_to("2012-02-29")

    pt.events.first.should == NanoCal::Models::Event.new(:title => "Test", :start => "2012-02-29 19:00:00 +0100", :stop => "2012-02-29 22:00:00 +0100")
    pt.events.last.should == NanoCal::Models::Event.new(:title => "Test", :start => "2012-03-01 09:00:00 +0100", :stop => "2012-03-01 10:30:00 +0100")
  end
end
