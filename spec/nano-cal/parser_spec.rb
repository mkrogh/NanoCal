require "spec_helper"

class ParserTest
  attr_accessor :events
  include NanoCal::Parser
end

describe NanoCal::Parser do
  it "parses json list to events" do
    event = NanoCal::Models::Event.new(:title => "Test", :start => "2012-04-13 19:00:00 +0100", :stop => "2012-04-13 22:00:00 +0100")

    pt = ParserTest.new
    pt.parse_file "spec/json/nano-cal-simple.json"
    
    pt.events.should == [event] 
  end
end
