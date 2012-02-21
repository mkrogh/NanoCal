require "spec_helper"

require "nano-cal/models"

class AdvanceTest
  attr_accessor :events
  include NanoCal::Export
end

describe NanoCal::Export do

  before(:each) do
    time1 = {:start => "2012-04-13 19:00:00 +0100", :stop => "2012-04-13 22:00:00 +0100"}
    time2 = {:start => "2012-04-14 09:00:00 +0100", :stop => "2012-04-14 10:30:00 +0100"}

    @events = [] 
    @events << NanoCal::Models::Event.new(:title => "Test", :start => time1[:start], :stop => time1[:stop])
    @events << NanoCal::Models::Event.new(:title => "Test", :start => time2[:start], :stop => time2[:stop])
  end 

  it "advances one event" do
    pt = AdvanceTest.new
    pt.events = [@events.first]
    pt.advance_to("2012-02-24")

    pt.events.first.should == NanoCal::Models::Event.new(:title => "Test", :start => "2012-02-24 19:00:00 +0100", :stop => "2012-02-24 22:00:00 +0100")
  end

  it "advances multiple events" do

    pt = AdvanceTest.new
    pt.events = @events
    pt.advance_to("2012-02-24")

    pt.events.last.should == NanoCal::Models::Event.new(:title => "Test", :start => "2012-02-25 09:00:00 +0100", :stop => "2012-02-25 10:30:00 +0100")
  end

  it "advances an event, month wrapover (and leap year)" do
    pt = AdvanceTest.new
    pt.events = @events
    pt.advance_to("2012-02-29")

    pt.events.first.should == NanoCal::Models::Event.new(:title => "Test", :start => "2012-02-29 19:00:00 +0100", :stop => "2012-02-29 22:00:00 +0100")
    pt.events.last.should == NanoCal::Models::Event.new(:title => "Test", :start => "2012-03-01 09:00:00 +0100", :stop => "2012-03-01 10:30:00 +0100")
  end

  it "advances non concecutive events" do
    e = @events.last
    e.start = e.start.advance(:days => 2)
    e.stop = e.stop.advance(:days => 2)

    pt = AdvanceTest.new
    pt.events = @events
    pt.advance_to "2012-02-24"

    pt.events.first.should == NanoCal::Models::Event.new(:title => "Test", :start => "2012-02-24 19:00:00 +0100", :stop => "2012-02-24 22:00:00 +0100")
    pt.events.last.should == NanoCal::Models::Event.new(:title => "Test", :start => "2012-02-27 09:00:00 +0100", :stop => "2012-02-27 10:30:00 +0100")
  end

  it "can advance events spanning muliple days" do
    event = @events.first
    event.stop = event.stop.advance :days => 2 #now spans 2 days

    pt = AdvanceTest.new
    pt.events = [event]
    pt.advance_to "2012-02-24"

    pt.events.first.should == NanoCal::Models::Event.new(:title => "Test", :start => "2012-02-24 19:00:00 +0100", :stop => "2012-02-26 22:00:00 +0100")
  end
end
