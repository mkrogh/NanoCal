require "spec_helper"

describe NanoCal::Models do
  describe "Event" do
    it "parses start date strings" do
      datetime = DateTime.parse("2012-04-13 19:00:00 +0100")
      event = NanoCal::Models::Event.new(:start => "2012-04-13 19:00:00 +0100")
      event.start.should_not eq "2012-04-13 19:00:00 +0100"
      event.start.should == datetime
    end
  
    it "parses stop date strings" do
      datetime = DateTime.parse("2011-03-12 20:00:00 +0100")
      event = NanoCal::Models::Event.new(:stop => "2011-03-12 20:00:00 +0100")
      event.stop.should_not eq "2011-03-12 20:00:00 +0100"
      event.stop.should == datetime
    end
  end
end
